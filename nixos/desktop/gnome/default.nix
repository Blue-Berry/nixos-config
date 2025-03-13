{pkgs, ...}: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = [
    pkgs.gnomeExtensions.blur-my-shell
  ];
}
