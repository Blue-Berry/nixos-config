{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.hardware.graphics.amd;
in
{
  options.nixosModules.hardware.graphics.amd = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable AMD graphics driver support";
  };

  config = lib.mkIf cfg {
    hardware.opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };

    boot.initrd.kernelModules = [ "amdgpu" ];
  };
}
