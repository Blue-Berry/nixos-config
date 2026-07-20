{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.stylix;
in
{
  options.homeModules.stylix = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Stylix home-manager specific configuration";
  };

  # Import shared stylix configuration from common
  imports = [
    ../../common/styling/stylix-common.nix
  ];

  config = lib.mkIf cfg {
    # home-manager-specific stylix configuration
    # Base config comes from common module

    # Explicitly enable cursor config generation (stylix sets package/name/size)
    home.pointerCursor.enable = true;

    stylix = {
      opacity = {
        terminal = 0.8;
      };
      targets = {
        zen-browser = {
          profileNames = [ "Main" ];
          enable = false;
        };
        hyprland.hyprpaper.enable = true;
        hyprpaper.enable = true;
        hyprlock = {
          enable = true;
          image.enable = true;
        };
        yazi.enable = true;
        bat.enable = true;
        btop.enable = true;
        hyprland.enable = true;
        spicetify.enable = false;
        ghostty.enable = true;
        fzf.enable = true;
        dunst.enable = !config.homeModules.desktop.dms;
        firefox = {
          enable = true;
          colorTheme.enable = true;
        };
        gtk = {
          enable = true;
        };
        xresources.enable = true;
        qt.enable = true;
        starship.enable = true;
        gnome = {
          image.enable = true;
          enable = true;
        };
        lazygit.enable = true;
      };
    };
  };
}
