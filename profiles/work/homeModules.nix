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
      enable = false;
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
              mode = "1920x1080@60Hz";
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
        {
          profile.name = "Ferdi-Desk";
          profile.outputs = [
            {
              criteria = "DVI-I-2";
              mode = "1920x1080";
              position = "0,0";
              scale = 1.0;
            }
            {
              criteria = "DVI-I-1";
              mode = "1920x1080";
              position = "1920,0";
              scale = 1.0;
            }
            {
              criteria = "eDP-1";
              status = "disable";
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
      startupApps = [
        {
          command = ["ghostty"];
          appId = "com.mitchellh.ghostty";
          monitor = "DVI-I-1";
          workspace = 1;
        }
        {
          command = [
            "emacsclient"
            "-c"
            "-a"
            ""
          ];
          appId = "emacs";
          title = ".*Doom Emacs$";
          monitor = "DVI-I-2";
          workspace = 1;
        }
        {
          command = ["zen-beta"];
          appId = "zen-beta";
          monitor = "HDMI-A-1";
          workspace = 1;
        }
        {
          command = ["spotify"];
          appId = "spotify";
          monitor = "DVI-I-2";
          workspace = 2;
        }
        {
          command = ["teams-for-linux"];
          appId = "electron";
          title = ".*Microsoft Teams$";
          monitor = "HDMI-A-1";
          workspace = 2;
        }
      ];
      layout.gaps = 5;
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
    games = false;
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
      "server" = {
        id = "JSPK5MY-IPIOJV6-ZN2WTXX-E5ZI62W-FWF4NCU-WU3NAZN-TQTBKQ2-IXTB2Q6";
      };
    };
    folders = {
      "Documents" = {
        path = "~/Documents";
        devices = [
          "phone"
          "personal"
          "iPad"
          "server"
        ];
        ignorePerms = false;
      };
      "roam" = {
        path = "~/org/roam/";
        devices = [
          "phone"
          "personal"
        ];
        ignorePerms = false;
      };
      "library" = {
        path = "~/library/";
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
