{
  lib,
  config,
  ...
}: let
  cfg = config.homeModules.xdgMime;
in {
  options.homeModules.xdgMime = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable XDG MIME type associations";
    };

    defaultBrowser = lib.mkOption {
      type = lib.types.str;
      default = "zen-browser.desktop";
      example = "firefox.desktop";
      description = "Desktop file for the default web browser";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      mimeApps.enable = true;
      mimeApps.defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop" "zathura.desktop"];
        "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
        "x-scheme-handler/wootwoot" = ["wootility-lekker.desktop"];
        "x-scheme-handler/web+wootwoot" = ["wootility-lekker.desktop"];
        "x-scheme-handler/http" = [cfg.defaultBrowser];
        "x-scheme-handler/https" = [cfg.defaultBrowser];
        "x-scheme-handler/chrome" = [cfg.defaultBrowser];
        "text/html" = [cfg.defaultBrowser];
        "application/x-extension-htm" = [cfg.defaultBrowser];
        "application/x-extension-html" = [cfg.defaultBrowser];
        "application/x-extension-shtml" = [cfg.defaultBrowser];
        "application/xhtml+xml" = [cfg.defaultBrowser];
        "application/x-extension-xhtml" = [cfg.defaultBrowser];
        "application/x-extension-xht" = [cfg.defaultBrowser];
        "x-scheme-handler/eclipse+command x-scheme-handler/eclipse+mpc" = ["_nix_store_jsjfg2zmqdp1r90kzkc5ld7409w0yaxg-CodeComposerStudio-12.6.0_ccs_eclipse_.desktop"];
        "application/zip" = ["org.gnome.FileRoller.desktop;"];
        "text/plain" = ["neovide.desktop;"];
        "application/x-shellscript" = ["neovide.desktop;"];
        "text/csv" = ["neovide.desktop;"];
        "application/pem-certificate-chain" = ["neovide.desktop;"];
        "audio/vnd.dts" = ["neovide.desktop;"];
        "text/x-makefile" = ["neovide.desktop;"];
      };
    };
  };
}
