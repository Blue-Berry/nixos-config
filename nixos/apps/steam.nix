{
  config,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        defaultgov = "performance";
        desiredgov = "performance";
        renice = 10;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  # systemd.user.services.start-steam = {
  #   enable = true;
  #   description = "Open Steam in the background at boot";
  #   wantedBy = ["graphical-session.target"];
  #   serviceConfig = {
  #     ExecStart = "${config.system.path}/bin/steam -nochatui -nofriendsui -silent %U";
  #     Restart = "on-failure";
  #     RestartSec = "5s";
  #   };
  # };
}
