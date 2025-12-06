{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.opencode;
in {
  options.homeModules.apps.opencode = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable OpenCode VSCode launcher";
  };

  config = lib.mkIf cfg {
    programs.opencode.enable = true;
    stylix.targets.opencode.enable = true;
  };
}
