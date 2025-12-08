{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.starship;
in {
  options.homeModules.apps.starship = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Starship shell prompt";
  };

  config = lib.mkIf cfg {
    home.packages = [pkgs.starship];
    programs.starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
