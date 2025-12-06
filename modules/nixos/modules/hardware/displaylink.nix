{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.hardware.displaylink;
in {
  options.nixosModules.hardware.displaylink = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable DisplayLink USB graphics support";
  };

  config = lib.mkIf cfg {
    services.xserver.videoDrivers = ["displaylink" "modesetting"];
    environment.systemPackages = with pkgs; [
      displaylink
    ];
  };
}
