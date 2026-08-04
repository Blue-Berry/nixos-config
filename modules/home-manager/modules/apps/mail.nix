{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.mail;

  # isync/msmtp speak XOAUTH2 (needed for Office365) via a Cyrus SASL plugin.
  # SASL loads plugins from a single directory, so merge the base mechanisms
  # (PLAIN/LOGIN, used by Gmail) with the xoauth2 plugin into one dir and
  # point SASL_PATH at it below.
  saslPlugins = pkgs.symlinkJoin {
    name = "sasl2-plugins-with-xoauth2";
    paths = [
      pkgs.cyrus_sasl.out
      pkgs.cyrus-sasl-xoauth2
    ];
  };
  saslPath = "${saslPlugins}/lib/sasl2";

  # oama hands out fresh OAuth2 access tokens for the Outlook account. Used
  # as the "password" for both mbsync (IMAP) and msmtp (SMTP).
  outlookToken = "${pkgs.oama}/bin/oama access liam.berry@rubiconsa.com";
in
{
  options.homeModules.apps.mail = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable mbsync (isync) mail sync + mu store for mu4e";
  };

  config = lib.mkIf cfg {
    # `mu` provides both the CLI indexer and the matching mu4e elisp
    # (site-lisp). See emacs.nix note: prefer this over epkgs.mu4e so the
    # mu4e library version always matches the `mu` binary.
    home.packages = [
      pkgs.mu
      pkgs.oama # OAuth2 token manager for the Outlook account
    ];

    # mbsync/msmtp need SASL_PATH set in the interactive shell so that a
    # manual `mbsync outlook` finds the xoauth2 plugin. The systemd service
    # gets it separately (see systemd.user.services.mbsync below).
    home.sessionVariables.SASL_PATH = saslPath;

    # oama config. client_id is Thunderbird's public Microsoft client (no
    # secret needed with device-code flow); tokens are encrypted to your GPG
    # key. Authorize once:  oama authorize microsoft liam.berry@rubiconsa.com --device
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

    # Generates ~/.mbsyncrc from the accounts.email definitions below.
    programs.mbsync.enable = true;

    # msmtp is the send path for both accounts; it selects the account from
    # the envelope From address (--read-envelope-from, set in Doom config).
    programs.msmtp.enable = true;

    # systemd timer that runs `mbsync` periodically, then re-indexes mu.
    services.mbsync = {
      enable = true;
      frequency = "*:0/5"; # every 5 minutes
      # Re-index after each sync. Requires `mu init ...` to have been run
      # once already (see the one-time setup note at the bottom).
      postExec = "${lib.getExe pkgs.mu} index";
    };

    # The timer's service runs outside the login shell, so give it SASL_PATH
    # (for the Outlook xoauth2 mech) explicitly.
    systemd.user.services.mbsync.Service.Environment = [ "SASL_PATH=${saslPath}" ];

    accounts.email = {
      # Maildirs live under ~/Mail/<account>. `mu init --maildir=~/Mail`.
      maildirBasePath = "Mail";

      accounts = {
        # ---- Gmail --------------------------------------------------------
        # Uses an App Password (Google account > Security > App passwords),
        # stored in pass:  pass insert email/gmail
        gmail = {
          primary = true;
          realName = "Liam Berry";
          address = "liamandberry@gmail.com";
          userName = "liamandberry@gmail.com";
          flavor = "gmail.com";
          passwordCommand = "${pkgs.pass}/bin/pass show email/gmail";

          mbsync = {
            enable = true;
            create = "maildir"; # create missing local folders
            expunge = "both";
            # Pin to password auth. Without this, now that the XOAUTH2 SASL
            # plugin is on SASL_PATH (for Outlook), Gmail would negotiate
            # XOAUTH2 and send the app password as a bearer token -> fails.
            extraConfig.account.AuthMechs = "LOGIN";
            patterns = [
              "*"
              # Gmail exposes labels as folders; skip the ones that are pure
              # duplicates. [Gmail]/All Mail is kept: it's the archive target
              # mu4e refiles into.
              "![Gmail]/Important"
              "![Gmail]/Starred"
            ];
          };

          msmtp.enable = true; # send via msmtp using the same pass entry
        };

        # ---- Outlook / Office365 (rubiconsa.com) --------------------------
        # Office365 requires OAuth2 (XOAUTH2); there is no app-password path.
        # `oama` obtains and refreshes the token; authorize it once with:
        #   oama authorize microsoft liam.berry@rubiconsa.com --device
        # See the one-time setup / caveats note in the assistant summary.
        outlook = {
          realName = "Liam Berry";
          address = "liam.berry@rubiconsa.com";
          userName = "liam.berry@rubiconsa.com";
          flavor = "outlook.office365.com";
          # oama prints a fresh access token; used as the XOAUTH2 bearer for
          # both IMAP (mbsync) and SMTP (msmtp).
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
        };
      };
    };
  };
}
