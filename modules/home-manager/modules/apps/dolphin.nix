{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.dolphion;
in {
  options.homeModules.apps.dolphion = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Dolphion File Explorer";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };
}
