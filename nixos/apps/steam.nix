{config, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;

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
