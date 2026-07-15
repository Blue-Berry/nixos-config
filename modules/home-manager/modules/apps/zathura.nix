{
  lib,
  config,
  ...
}:
let
  cfg = config.homeModules.apps.zathura;
in
{
  options.homeModules.apps.zathura = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Zathura PDF viewer";
  };

  config = lib.mkIf cfg {
    programs.zathura = {
      enable = true;
    };
    stylix.targets.zathura = {
      enable = true;
      colors.enable = true;
      opacity.enable = true;
    };
  };
}
