{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.hardware.ratbag;
in
{
  options.nixosModules.hardware.ratbag = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable ratbag mouse configuration with Piper";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [
      pkgs.libratbag
      pkgs.piper
    ];
    services.ratbagd.enable = true;
  };
}
