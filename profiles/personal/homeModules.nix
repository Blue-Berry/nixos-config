{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./commonModules.nix
  ];

  # Apps
  homeModules.apps.enable = true;
  homeModules.apps.thunderbird = false;

  # Desktop
  homeModules.desktop = {
    dconf = true;
    hyprland = {
      enable = false;
      monitorProfile = "personal";
    };
    kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "personal";
          profile.outputs = [
            {
              criteria = "DP-2";
              mode = "1920x1080";
              position = "0,0";
              scale = 1.0;
            }
            {
              criteria = "HDMI-A-1";
              mode = "1920x1080";
              position = "1920,0";
              scale = 1.0;
            }
          ];
        }
      ];
    };
    niri = {
      enable = true;
      monitors = [
        "DP-2" # Mod+1 - Left monitor
        "HDMI-A-1" # Mod+2 - Right monitor
      ];
    };
    waybar = false;
    dms = true;
  };

  # Packages
  homeModules.packages = {
    cli = true;
    gui = true;
    programming = true;
    llm.enable = true;
    games = true;
  };

  # Other modules
  homeModules.envVars = {
    enable = true;
    muProfile = "personal";
  };

  homeModules.stylix = true;

  homeModules.syncthing = {
    enable = true;
    devices = {
      "phone" = {
        id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
      };
      "work" = {
        id = "R6KDI5U-O4CUY7L-IATHVCY-MIDKOJR-MSLFJVT-VE6HTMN-JDALETZ-AX4SRQC";
      };
      "iPad" = {
        id = "OMHQ3OT-D4PW3LQ-5A75Z4K-4I6OUMM-YGKIQCV-IKPEJJC-7FR6TUR-CUL5EQZ";
      };
      "server" = {
        id = "NHYRSMI-44ZQYV2-H35TA3I-NXQ7PT5-VINFYAS-L2JXBWJ-SSGE64A-3RPL7QE";
      };
    };
    folders = {
      "Documents" = {
        path = "~/Documents";
        devices = [
          "phone"
          "work"
          "iPad"
          "server"
        ];
        ignorePerms = false;
      };
      "roam" = {
        path = "~/org/roam/";
        devices = [
          "phone"
          "work"
        ];
        ignorePerms = false;
      };
      "library" = {
        path = "~/library/";
        devices = [
          "phone"
          "work"
          "iPad"
          "server"
        ];
        ignorePerms = false;
      };
      Audiobooks = {
        path = "~/audiobooks/";
        devices = [
          "phone"
          "personal"
          "iPad"
          "server"
        ];
        ignorePerms = false;
      };
    };
  };
}
