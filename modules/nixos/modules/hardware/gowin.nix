{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.hardware.gowin;
in
{
  options.nixosModules.hardware.gowin = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Gowin FPGA support";
  };

  config = lib.mkIf cfg {
    services.udev.packages = [ pkgs.gowin-udev ];
  };
}
