{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.hardware.solaar;
in
{
  options.nixosModules.hardware.solaar = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Solaar for Logitech devices";
  };

  config = lib.mkIf cfg {
    # nixpkgs' native module (the upstreamed Svenum one). userService runs the
    # tray app, matching the old services.solaar behaviour.
    programs.solaar = {
      enable = true;
      package = pkgs.solaar;
      userService.enable = true;
    };
  };
}
