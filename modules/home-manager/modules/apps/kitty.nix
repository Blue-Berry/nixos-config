{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.kitty;
in {
  options.homeModules.apps.kitty = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Kitty terminal emulator";
  };

  config = lib.mkIf cfg {
    home.packages = [pkgs.kitty];
    programs.kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      # font = {
      #   # name = "FiraCode Nerd Font Mono";
      #   name = lib.mkForce "Hasklug Nerd Font Mono";
      #   size = 10;
      # };
      settings = {
        # background_opacity = "0.8";
        background_blur = 1;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
      };
    };
  };
}
