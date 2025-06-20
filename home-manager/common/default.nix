{...}: {
  imports = [
    ../apps/delta.nix
    ../apps/direnv.nix
    ../apps/git.nix
    ../apps/kitty.nix
    ../apps/ghostty.nix
    ../apps/spotify.nix
    ../apps/starship.nix
    ../apps/yazi/yazi.nix
    ../apps/zsh.nix
    ../apps/neovide.nix
    ../apps/zathura.nix

    ../env-vars.nix
    ../packages.nix
    ../stylix.nix

    ../desktop/dconf.nix
    ../../overlays/enable.nix
  ];

  programs.neovim.enable = true;

  xdg = {
    mimeApps.enable = true;
    mimeApps.defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop" "zathura.desktop"];
      "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
      "x-scheme-handler/wootwoot" = ["wootility-lekker.desktop"];
      "x-scheme-handler/web+wootwoot" = ["wootility-lekker.desktop"];
      "x-scheme-handler/http" = ["zen-browser.desktop"];
      "x-scheme-handler/https" = ["zen-browser.desktop"];
      "x-scheme-handler/chrome" = ["zen-browser.desktop"];
      "text/html" = ["zen-browser.desktop"];
      "application/x-extension-htm" = ["zen-browser.desktop"];
      "application/x-extension-html" = ["zen-browser.desktop"];
      "application/x-extension-shtml" = ["zen-browser.desktop"];
      "application/xhtml+xml" = ["zen-browser.desktop"];
      "application/x-extension-xhtml" = ["zen-browser.desktop"];
      "application/x-extension-xht" = ["zen-browser.desktop"];
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
}
