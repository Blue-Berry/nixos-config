{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.hardware.solaar;
in {
  options.nixosModules.hardware.solaar = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Solaar for Logitech devices";
  };

  config = lib.mkIf cfg {
    services.solaar = {
      enable = true;
      package = pkgs.solaar;
    };
  };
}
