{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.mail;
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
    home.packages = [ pkgs.mu ];

    # Generates ~/.mbsyncrc from the accounts.email definitions below.
    programs.mbsync.enable = true;

    # systemd timer that runs `mbsync` periodically, then re-indexes mu.
    services.mbsync = {
      enable = true;
      frequency = "*:0/5"; # every 5 minutes
      # Re-index after each sync. Requires `mu init ...` to have been run
      # once already (see the one-time setup note at the bottom).
      postExec = "${lib.getExe pkgs.mu} index";
    };

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
          # TODO: replace with your actual gmail address
          address = "liamandberry@gmail.com";
          userName = "liamandberry@gmail.com";
          flavor = "gmail.com";
          passwordCommand = "${pkgs.pass}/bin/pass show email/gmail";

          mbsync = {
            enable = true;
            create = "maildir"; # create missing local folders
            expunge = "both";
            patterns = [
              "*"
              # Gmail exposes labels as folders; skip the ones that just
              # duplicate mail you already have locally.
              "![Gmail]/All Mail"
              "![Gmail]/Important"
              "![Gmail]/Starred"
            ];
          };
        };

        # ---- Outlook / Office365 (rubiconsa.com) --------------------------
        # NOTE: Office365 requires OAuth2 (XOAUTH2). Basic auth / app
        # passwords are disabled on most tenants, so mbsync.enable is left
        # false until an OAuth2 token helper (oama / mutt_oauth2.py) is set
        # up. Once you have a token command working, set:
        #   passwordCommand = "<command that prints a fresh access token>";
        #   mbsync.extraConfig.account.AuthMechs = "XOAUTH2";
        # and flip mbsync.enable to true.
        outlook = {
          realName = "Liam Berry";
          address = "liam.berry@rubiconsa.com";
          userName = "liam.berry@rubiconsa.com";
          flavor = "outlook.office365.com";
          # Placeholder until OAuth2 is configured.
          passwordCommand = "${pkgs.pass}/bin/pass show email/rubiconsa";

          mbsync = {
            enable = false; # <- enable after OAuth2 token helper is set up
            create = "maildir";
            expunge = "both";
          };
        };
      };
    };
  };
}
