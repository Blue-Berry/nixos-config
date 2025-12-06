{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.hardware.tpLinkWifi;
in {
  options.nixosModules.hardware.tpLinkWifi = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable TP-Link Archer USB WiFi driver";
  };

  config = lib.mkIf cfg {
    boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
  };
}
