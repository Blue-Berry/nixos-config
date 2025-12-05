{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];
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
  # xdg.configFile."niri/config.kdl".source = ./config.kdl;

  stylix.targets = {
    fuzzel.enable = true;
    swaylock.enable = true;
    mako.enable = true;
    niri.enable = true;
  };
  programs.niri.settings = {
    # TODO: make this dynamic
    outputs."DVI-I-1" = {
      position.x = 0;
      position.y = 0;
    };
    outputs."DVI-I-2" = {
      position.x = 1920;
      position.y = 0;
    };
    outputs."HDMI-A-1" = {
      position.x = 3840;
      position.y = 0;
    };
  };
}
