{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.hardware.touchpad;
in
{
  options.nixosModules.hardware.touchpad = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable touchpad support";
  };

  config = lib.mkIf cfg {
    services.libinput.enable = true;
  };
}
