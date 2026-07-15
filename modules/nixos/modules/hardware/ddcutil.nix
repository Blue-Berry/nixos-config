{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.hardware.ddcutil;
in
{
  options.nixosModules.hardware.ddcutil = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable ddcutil for monitor control (users need to be added to i2c group)";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [ pkgs.ddcutil ];
    boot.kernelModules = [ "i2c-dev" ];

    services.udev.extraRules = ''
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';

    users.groups.i2c = { };
  };
}
