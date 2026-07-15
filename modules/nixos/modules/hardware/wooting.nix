{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.hardware.wooting;
in
{
  options.nixosModules.hardware.wooting = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Wooting keyboard support";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [ pkgs.wootility ];
    services.udev.packages = [ pkgs.wooting-udev ];
  };
}
