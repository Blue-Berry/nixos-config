{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.homeModules.packages.gui;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.homeModules.packages.gui = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.packages.enable;
    defaultText = lib.literalExpression "config.homeModules.packages.enable";
    description = "Enable GUI application packages";
  };

  config = lib.mkIf cfg {
    programs.zen-browser.enable = true;
    home.packages = with pkgs; [
      # Browsers
      chromium
      firefox

      # Communication
      discord
      teams-for-linux

      # Media
      calibre
      easyeffects
      mpv
      vlc

      # Development
      # vscode
      obsidian

      # Utilities
      btop-rocm
      dotool
      glow
      gparted
      hydrapaper
      inetutils
      libreoffice-fresh
      # newsflash # slow build
      qbittorrent
      showcolors
      steam-run
      wineWow64Packages.stable
      winetricks
      wl-clipboard-x11

      # Fonts
      font-awesome

      # Gaming
      prismlauncher

      # Other
      base16-schemes
      inputs.gowin-eda.packages.${pkgs.system}.gowin-eda
      ntfs3g
      okolors

    ];
  };
}
