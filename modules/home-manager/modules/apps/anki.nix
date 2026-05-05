{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.anki;
in {
  options.homeModules.apps.anki = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.homeModules.apps.enable;
      defaultText = lib.literalExpression "config.homeModules.apps.enable";
      description = "Enable Anki";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "liamandberry@gmail.com";
      description = "Username for Anki";
    };
    darkMode = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use dark mode";
    };
    keyFile = lib.mkOption {
      type = lib.types.path;
      default = "/home/liam/.config/ankiKey.txt";
      description = "Path to Anki key file";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.anki = {
      enable = true;
      theme =
        if cfg.darkMode
        then "dark"
        else "light";
      profiles."User 1".sync = {
        autoSync = true;
        username = cfg.username;
        syncMedia = true;
        keyFile = cfg.keyFile;
      };
      addons = [
        pkgs.ankiAddons.review-heatmap
        pkgs.ankiAddons.passfail2
        # pkgs.ankiAddons.recolor
      ];
    };
    stylix.targets.anki = {
      enable = true;
      colors.enable = false;
    };
  };
}
