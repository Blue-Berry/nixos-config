{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.hardware.bluetooth;
in {
  options.nixosModules.hardware.bluetooth = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Bluetooth support with Blueman";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [pkgs.blueman];
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
