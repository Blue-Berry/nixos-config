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
  nixosModules.boot.enable = true;

  # Apps
  nixosModules.apps = {
    emacs = true;
    kanata = {
      enable = true;
      devices = [
        # Commented out - uncomment and adjust paths for your setup
        # Use `ls /dev/input/by-path/` to find your keyboard devices
        # "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        # "/dev/input/by-path/pci-0000:00:14.0-usb-0:1:1.1-event-kbd"
        # "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:1:1.1-event-kbd"
      ];
    };
    pass = true;
    steam = true;
    wireguard.enable = true;  # No custom interfaces for personal profile
    zsh = true;
  };

  # Desktop Environments
  nixosModules.desktop = {
    gnome = true;
    hyprland = true;
  };

  # Greeter
  nixosModules.greeter = {
    regreet = false;
    gdm = false;
    sddm = false;
    greetdHyprland = {
      enable = true;
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
