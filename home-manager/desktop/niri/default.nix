{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # waybar is imported at a higher level to avoid duplicate imports
    # ../waybar
  ];
  programs.fuzzel = {
    enable = true; # Super+D in the default setting (app launcher)
    package = pkgs.fuzzel;
  };
  programs.swaylock = {
    enable = true; # Super+Alt+L in the default setting (screen locker)
    package = pkgs.swaylock;
  };
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  home.packages = with pkgs; [
    swaybg # wallpaper
  ];
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
