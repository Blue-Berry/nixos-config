{
  lib,
  config,
  ...
}:
let
  cfg = config.homeModules.apps.direnv;
in
{
  options.homeModules.apps.direnv = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable direnv for directory-specific environments";
  };

  config = lib.mkIf cfg {
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
    services.lorri.enable = true;
  };
}
