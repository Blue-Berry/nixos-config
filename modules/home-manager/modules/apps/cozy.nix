{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.cozy;
in {
  options.homeModules.apps.cozy = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Cozy audiobook reader";
  };

  config = lib.mkIf cfg {
    home.packages = [
      pkgs.cozy
    ];
  };
}
