{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.nixosModules.styling.stylix;
in {
  options.nixosModules.styling.stylix = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.styling.enable;
    defaultText = lib.literalExpression "config.nixosModules.styling.enable";
    description = "Enable Stylix system-wide theming";
  };

  # Import shared stylix configuration from common
  imports = [
    ../../../common/styling/stylix-common.nix
  ];

  config = lib.mkIf cfg {
    # NixOS-specific stylix targets only
    # Base config (image, polarity, cursor, fonts) comes from common module

    stylix = {
      # ls-colors.enable = true;
      targets = {
        grub = {
          enable = true;
          useWallpaper = true;
        };
        gnome.enable = true;
        gtk.enable = true;
        qt.enable = true;
      };
    };
  };
}
