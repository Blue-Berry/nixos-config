{pkgs, ...}: {
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = [
    pkgs.gnomeExtensions.blur-my-shell
  ];
}
