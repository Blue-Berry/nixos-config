{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.nixosModules.desktop.niri;
in {
  options.nixosModules.desktop.niri = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.desktop.enable;
    defaultText = lib.literalExpression "config.nixosModules.desktop.enable";
    description = "Enable Niri compositor";
  };

  config = lib.mkIf cfg {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.enable = true;
    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = true; # secret service
    security.pam.services.swaylock = {};
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
