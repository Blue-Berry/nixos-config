{
  lib,
  config,
  ...
}: let
  cfg = config.homeModules.apps.vivid;
in {
  options.homeModules.apps.vivid = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Vivid LS_COLORS generator";
  };

  config = lib.mkIf cfg {
    programs.vivid = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    stylix.targets.vivid.enable = true;
  };
}
