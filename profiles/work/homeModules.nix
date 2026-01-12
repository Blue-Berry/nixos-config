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

  # Desktop
  homeModules.desktop = {
    dconf = true;
    hyprland = {
      enable = true;
      monitorProfile = "work";
    };
    kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "work-docked";
          profile.outputs = [
            {
              criteria = "DVI-I-1";
              mode = "1920x1080";
              position = "0,0";
              scale = 1.0;
            }
            {
              criteria = "DVI-I-2";
              mode = "1920x1080";
              position = "1920,0";
              scale = 1.0;
            }
            {
              criteria = "HDMI-A-1";
              mode = "1920x1080";
              position = "3840,0";
              scale = 1.0;
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }
        {
          profile.name = "work-undocked";
          profile.outputs = [
            {
              criteria = "DP-1";
              mode = "1920x1080@120Hz";
              scale = 1.0;
            }
          ];
        }
      ];
    };
    niri = {
      enable = true;
      monitors = [
        "DVI-I-1" # Mod+1 - Left monitor
        "DVI-I-2" # Mod+2 - Center monitor
        "HDMI-A-1" # Mod+3 - Right monitor
      ];
    };
    waybar = true;
  };

  # Packages
  homeModules.packages = {
    cli = true;
    gui = true;
    programming = true;
    llm.enable = true;
  };

  # Other modules
  homeModules.envVars = {
    enable = true;
    muProfile = "work";
  };

  homeModules.stylix = true;

  homeModules.syncthing = {
    enable = true;
    devices = {
      "phone" = {
        id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
      };
      "personal" = {
        id = "EAQAYXJ-XQMSQRB-F4FCS5Q-W7AC2LO-S7EBTFK-EHWSU5O-LAN5RBC-5CXP5AC";
      };
      "iPad" = {
        id = "OMHQ3OT-D4PW3LQ-5A75Z4K-4I6OUMM-YGKIQCV-IKPEJJC-7FR6TUR-CUL5EQZ";
      };
    };
    folders = {
      "Documents" = {
        path = "~/Documents";
        devices = ["phone" "personal" "iPad"];
        ignorePerms = false;
      };
      "roam" = {
        path = "~/org/roam/";
        devices = ["phone" "personal"];
        ignorePerms = false;
      };
      "library" = {
        path = "~/library/";
        devices = ["phone" "personal" "iPad"];
        ignorePerms = false;
      };
    };
  };
}
