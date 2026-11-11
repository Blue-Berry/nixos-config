{
  dendritic.profiles.personal.nixos = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        programs.steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
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
      };
    }
  );
}
