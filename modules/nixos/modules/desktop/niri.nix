{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.nixosModules.desktop.niri;
in
{
  options.nixosModules.desktop.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.desktop.enable;
      defaultText = lib.literalExpression "config.nixosModules.desktop.enable";
      description = "Enable Niri compositor";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      # niri requires libdisplay-info 0.2.0, which our nixpkgs no longer ships
      # (it's at 0.4.0). Borrow 0.2.0 from niri's own pinned nixpkgs so the
      # niri overlay below finds it. Must come before the niri overlay.
      (final: prev: {
        libdisplay-info_0_2 =
          inputs.nixpkgs-niri.legacyPackages.${prev.stdenv.hostPlatform.system}.libdisplay-info_0_2;
      })
      inputs.niri.overlays.niri
    ];
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.enable = true;
    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = true; # secret service
    security.pam.services.swaylock = { };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
