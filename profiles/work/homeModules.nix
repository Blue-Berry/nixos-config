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
    niri = {
      enable = true;
      outputs = {
        "DVI-I-1".position = {
          x = 0;
          y = 0;
        };
        "DVI-I-2".position = {
          x = 1920;
          y = 0;
        };
        "HDMI-A-1".position = {
          x = 3840;
          y = 0;
        };
      };
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
    };
    folders = {
      "Documents" = {
        path = "~/Documents";
        devices = ["phone" "personal"];
        ignorePerms = false;
      };
      "roam" = {
        path = "~/org/roam/";
        devices = ["phone" "personal"];
        ignorePerms = false;
      };
    };
  };
}
