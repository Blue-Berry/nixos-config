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
        "DP-2".position = {
          x = 0;
          y = 0;
        };
        "HDMI-A-1".position = {
          x = 1920;
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
    };
    folders = {
      "Documents" = {
        path = "~/Documents";
        devices = ["phone" "work"];
        ignorePerms = false;
      };
      "roam" = {
        path = "~/org/roam/";
        devices = ["phone" "work"];
        ignorePerms = false;
      };
    };
  };
}
