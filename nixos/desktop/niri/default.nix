{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
