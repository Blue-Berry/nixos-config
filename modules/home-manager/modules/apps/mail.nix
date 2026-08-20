{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.mail;

  # XOAUTH2 (Office365) needs a Cyrus SASL plugin. SASL loads plugins from one
  # dir, so merge the base mechs (PLAIN/LOGIN, for Gmail) with xoauth2 and point
  # SASL_PATH at the result.
  saslPlugins = pkgs.symlinkJoin {
    name = "sasl2-plugins-with-xoauth2";
    paths = [
      pkgs.cyrus_sasl.out
      pkgs.cyrus-sasl-xoauth2
    ];
  };
  saslPath = "${saslPlugins}/lib/sasl2";

  # oama prints a fresh OAuth2 token, used as the password for mbsync, msmtp and
  # goimapnotify. It shells out to gpg to decrypt its cache, so gpg must be on
  # PATH — but the imapnotify units pin PATH to mbsync's bin, and goimapnotify
  # exec's bare commands directly (a shell only for pipes/redirects), so a
  # `PATH=... oama` prefix would become argv[0]. A wrapper script sidesteps both.
  outlookToken = "${pkgs.writeShellScript "oama-outlook-token" ''
    export PATH=${pkgs.gnupg}/bin:$PATH
    exec ${pkgs.oama}/bin/oama access liam.berry@rubiconsa.com
  ''}";

  # emacsclient from the system profile (Emacs runs as a daemon here).
  emacsclient = "/run/current-system/sw/bin/emacsclient";

  # mbsync refuses concurrent channel access and mu allows only one writer, so
  # the timer and both push hooks would collide. Run every sync under one lock.
  # For indexing: an open mu4e holds the Xapian write lock, so a CLI `mu index`
  # fails with "database locked" whenever Emacs is up — reindex through the live
  # mu server via emacsclient when it's running, else fall back to the CLI.
  mailSync =
    name: syncCmd:
    "${pkgs.writeShellScript "mail-sync-${name}" ''
      exec ${pkgs.util-linux}/bin/flock -w 300 "$HOME/.cache/mail-sync.lock" \
        ${pkgs.bash}/bin/bash -c '
          ${syncCmd}
          if [ "$(${emacsclient} -e "(and (fboundp (quote mu4e-running-p)) (mu4e-running-p))" 2>/dev/null)" = t ]; then
            ${emacsclient} -e "(mu4e-update-index)" >/dev/null 2>&1
          else
            ${lib.getExe pkgs.mu} index
          fi
        '
    ''}";
in
{
  options.homeModules.apps.mail = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable mbsync (isync) mail sync + mu store for mu4e";
  };

  config = lib.mkIf cfg {
    # `mu` provides both the CLI indexer and the matching mu4e elisp; prefer it
    # over epkgs.mu4e so the library version matches the binary (see emacs.nix).
    home.packages = [
      pkgs.mu
      pkgs.oama
    ];

    # So a manual `mbsync outlook` in a shell finds the xoauth2 plugin (systemd
    # services get it via Environment below).
    home.sessionVariables.SASL_PATH = saslPath;

    # Thunderbird's public MS client_id (device-code flow, no secret); tokens
    # encrypted to the GPG key. Authorize once:
    #   oama authorize microsoft liam.berry@rubiconsa.com --device
    xdg.configFile."oama/config.yaml".text = ''
      encryption:
        tag: GPG
        contents: liamandberry@gmail.com

      services:
        microsoft:
          client_id: 9e5f94bc-e8a4-4e73-b8be-63364c29d753
          tenant: common
          auth_scope: https://outlook.office.com/IMAP.AccessAsUser.All https://outlook.office.com/SMTP.Send offline_access
    '';

    programs.mbsync.enable = true;
    programs.msmtp.enable = true;

    # Hold an IMAP IDLE connection per account so a sync fires the instant mail
    # lands (see the per-account `imapnotify` blocks).
    services.imapnotify.enable = true;

    # Periodic fallback for the IDLE connections (push handles the common case).
    services.mbsync = {
      enable = true;
      frequency = "*:0/15";
    };

    # These services run outside the login shell, so hand them SASL_PATH for the
    # mbsync they spawn (Outlook XOAUTH2, Gmail LOGIN). goimapnotify itself
    # speaks XOAUTH2 in Go and needs no plugin. The timer syncs both accounts
    # through the same lock as the push hooks.
    systemd.user.services.mbsync.Service = {
      Environment = [ "SASL_PATH=${saslPath}" ];
      ExecStart = lib.mkForce (mailSync "all" "${pkgs.isync}/bin/mbsync -a");
    };
    systemd.user.services."imapnotify-gmail".Service.Environment = [ "SASL_PATH=${saslPath}" ];
    systemd.user.services."imapnotify-outlook".Service.Environment = [ "SASL_PATH=${saslPath}" ];

    accounts.email = {
      maildirBasePath = "Mail"; # ~/Mail/<account>; `mu init --maildir=~/Mail`

      accounts = {
        # Gmail: App Password stored in `pass insert email/gmail`.
        gmail = {
          primary = true;
          realName = "Liam Berry";
          address = "liamandberry@gmail.com";
          userName = "liamandberry@gmail.com";
          flavor = "gmail.com";
          passwordCommand = "${pkgs.pass}/bin/pass show email/gmail";

          mbsync = {
            enable = true;
            create = "maildir";
            expunge = "both";
            # Pin to password auth, else the xoauth2 plugin on SASL_PATH makes
            # Gmail negotiate XOAUTH2 and send the app password as a bearer.
            extraConfig.account.AuthMechs = "LOGIN";
            patterns = [
              "*"
              # Skip pure-duplicate/noise labels. [Gmail]/All Mail is the big
              # one — a copy of every message — so excluding it ~halves the sync.
              "![Gmail]/Important"
              "![Gmail]/Starred"
              "![Gmail]/All Mail"
              "![Gmail]/Spam"
              "![Gmail]/Trash"
            ];
          };

          msmtp.enable = true;

          imapnotify = {
            enable = true;
            boxes = [ "INBOX" ];
            # Sync only INBOX on push (the box we watch); a full multi-folder
            # sync is ~4x slower over Gmail's latency. The timer covers the rest.
            onNotify = mailSync "gmail" "${pkgs.isync}/bin/mbsync gmail:INBOX";
            # mbsync reads only the first line of the pass entry, but
            # goimapnotify sends the whole output; take line 1 to match.
            extraConfig.passwordCmd = "${pkgs.pass}/bin/pass show email/gmail | ${pkgs.coreutils}/bin/head -n1";
          };
        };

        # Outlook / Office365: OAuth2 only. Authorize once:
        #   oama authorize microsoft liam.berry@rubiconsa.com --device
        outlook = {
          realName = "Liam Berry";
          address = "liam.berry@rubiconsa.com";
          userName = "liam.berry@rubiconsa.com";
          flavor = "outlook.office365.com";
          passwordCommand = outlookToken;

          mbsync = {
            enable = true;
            create = "maildir";
            expunge = "both";
            extraConfig.account.AuthMechs = "XOAUTH2";
          };

          msmtp = {
            enable = true;
            extraConfig.auth = "xoauth2";
          };

          imapnotify = {
            enable = true;
            boxes = [ "INBOX" ];
            onNotify = mailSync "outlook" "${pkgs.isync}/bin/mbsync outlook:INBOX";
            extraConfig.xoauth2 = true;
          };
        };
      };
    };
  };
}
