{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.desktop.hyprlock;
in
{
  options.nixosModules.desktop.hyprlock = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.desktop.enable;
    defaultText = lib.literalExpression "config.nixosModules.desktop.enable";
    description = "Enable Hyprlock screen lock";
  };

  config = lib.mkIf cfg {
    programs.hyprlock.enable = true;
  };
}
