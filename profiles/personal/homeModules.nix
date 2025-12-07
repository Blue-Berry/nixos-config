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
  homeModules.apps = {
    delta = true;
    direnv = true;
    git.enable = true; # Uses common user config for name/email
    kitty = true;
    ghostty = true;
    neovide = true;
    nushell = true;
    opencode = true;
    spotify = true;
    starship = true;
    vivid = true;
    yazi = true;
    zathura = true;
    zsh = true;
  };

  # Desktop
  homeModules.desktop = {
    dconf = true;
    hyprland = {
      enable = true;
      monitorProfile = "personal";
    };
    niri.enable = true; # Uses default empty outputs
    waybar = true;
  };

  # Packages
  homeModules.packages = {
    cli = true;
    programming = true;
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
