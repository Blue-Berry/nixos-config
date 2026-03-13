{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.nixosModules.desktop.dms;
in {
  imports = [
    inputs.dms.nixosModules.dank-material-shell
  ];

  options.nixosModules.desktop.dms = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable DankMaterialShell";
    };
  };

  config = lib.mkIf cfg.enable {
    # Disable niri-flake's polkit agent in favor of DMS's built-in one
    systemd.user.services.niri-flake-polkit.enable = lib.mkIf config.nixosModules.desktop.niri.enable false;
  };
}
