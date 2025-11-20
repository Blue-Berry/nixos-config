{pkgs, ...}: {
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [pkgs.orca];
  environment.systemPackages = [
    pkgs.gnomeExtensions.blur-my-shell
  ];
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
