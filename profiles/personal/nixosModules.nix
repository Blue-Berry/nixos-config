{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./commonModules.nix
  ];

  # Boot Configuration
  nixosModules.boot = {
    enable = true;
    dualBoot = false;
  };

  # Apps
  nixosModules.apps = {
    cachix-agent = true;
    emacs = true;
    kanata = {
      enable = true;
    };
    pass = true;
    steam = true;
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = ["10.12.0.200/32"];
          listenPort = 51820;
          privateKeyFile = "/home/liam/wireguard-keys/private";
          peers = [
            {
              publicKey = "r2drw8KEHF9OO1L/rGT4iNYl1k9XNmtO58l5UMyB3DM=";
              allowedIPs = ["10.12.0.0/16"];
              endpoint = "102.133.148.40:51820";
              persistentKeepalive = 25;
            }
          ];
        };
        wg1 = {
          ips = ["10.64.0.2/32"];
          listenPort = 51821;
          privateKeyFile = "/home/liam/wireguard-keys/private";
          peers = [
            {
              publicKey = "MYaTPEhxXQANDdHW9lPdJ4D4Yrbrk4PPP/v9X6BQ+hc=";
              allowedIPs = ["10.64.0.0/16"];
              endpoint = "grovewalk.duckdns.org:51820";
              persistentKeepalive = 25;
            }
          ];
        };
      };
    };
    zsh = true;
    platformio = false;
  };

  # Desktop Environments
  nixosModules.desktop = {
    gnome = true;
    hyprland = true;
    niri.enable = true;
    niri.unstable = true;
  };

  # Greeter
  nixosModules.greeter = {
    regreet = true;
    gdm = false;
    sddm = false;
    greetdHyprland = {
      enable = false;
      username = "liam";
    };
  };

  # Hardware
  nixosModules.hardware = {
    bluetooth = true;
    ddcutil = true;
    gowin = true;
    logicAnalyzer = true;
    ntfs = true;
    ratbag = true;
    solaar = true;
    sound = true;
    wooting = true;
  };

  # System
  nixosModules.system = {
    cache = true;
    containers = true;
    envVars = {
      enable = true;
      muProfile = "personal";
    };
    flatpak = true;
    gc.enable = true;
    packages = true;
    ports.enable = true;
    vm = {
      enable = true;
      username = "liam";
    };
  };

  # Styling
  nixosModules.styling = {
    fonts = true;
    stylix = true;
  };

  # Games
  nixosModules.games.sunshine = true;
}
