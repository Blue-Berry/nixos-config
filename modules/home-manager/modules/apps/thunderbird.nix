{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.thunderbird;
in
{
  options.homeModules.apps.thunderbird = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Thunderbird";
  };

  config = lib.mkIf cfg {
    # programs.thunderbird.enable = true;

    home.packages = [ pkgs.thunderbird-latest-unwrapped ];
  };
}
