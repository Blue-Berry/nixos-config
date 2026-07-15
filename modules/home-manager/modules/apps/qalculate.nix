{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.qalculate;
in
{
  options.homeModules.apps.qalculate = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "multi-purpose desktop calculator";
  };
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      libqalculate
      qalculate-qt
    ];
    programs.qalculate = {
      enable = true;
      settings = {
        General = {
          colorize = 1;
          precision = 10;
          save_definitions_on_exit = 0;
          save_mode_on_exit = 1;
        };
        Mode = {
          angle_unit = 1;
          calculate_as_you_type = 1;
          max_deci = -1;
          min_deci = 0;
          number_base = 10;
        };
      };
    };
  };
}
