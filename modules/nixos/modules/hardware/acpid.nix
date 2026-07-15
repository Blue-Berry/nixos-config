{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.hardware.acpid;
in
{
  options.nixosModules.hardware.acpid = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable ACPI daemon for power management events";
  };

  config = lib.mkIf cfg {
    services.acpid.enable = true;
  };
}
