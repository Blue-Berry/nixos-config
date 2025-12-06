{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.hardware.logicAnalyzer;
in {
  options.nixosModules.hardware.logicAnalyzer = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable logic analyzer tools (sigrok/pulseview)";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [
      pkgs.sigrok-firmware-fx2lafw
      pkgs.pulseview
      pkgs.sigrok-cli
    ];
  };
}
