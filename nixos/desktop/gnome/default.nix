{pkgs, ...}: {
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = [
    pkgs.gnomeExtensions.blur-my-shell
  ];
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
