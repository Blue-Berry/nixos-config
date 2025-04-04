# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Import your generated (nixos-generate-config) hardware configuration
    ../../nixos/boot.nix
    ../../nixos/apps/zsh.nix

    ../../nixos/packages/default.nix
    ../../overlays/enable.nix
    ../../nixos/flake-options.nix
    ../../nixos/fonts.nix
    # ../../nixos/cursor.nix
    ../../nixos/containers.nix

    ../../nixos/hardware/bluetooth.nix
    ../../nixos/hardware/sound.nix
    # ./hardware/graphics-amd.nix
    ../../nixos/hardware/touchpad.nix
    # ../../nixos/hardware/displaylink/default.nix
    ../../nixos/hardware/wooting.nix
    ../../nixos/hardware/solaar.nix
    ../../nixos/hardware/ratbag.nix
    ../../nixos/hardware/tp-link-archer-usb-wifi.nix

    ../../nixos/apps/nvim.nix
    ../../nixos/apps/steam.nix
    ../../nixos/apps/wireguard.nix
    ../../nixos/apps/ollama.nix

    ../../nixos/ports.nix
    ../../nixos/stylix.nix

    ../../nixos/desktop/hyprland/default.nix
    # ./desktop/kde/default.nix
    ../../nixos/desktop/gnome/default.nix

    ../../nixos/system/gc.nix
  ];

  #NOTE: Basic system configuration

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };
  services.printing.enable = true;

  users.users = {
    ${userSettings.username} = {
      isNormalUser = true;
      initialPassword = "stuff";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["networkmanager" "wheel" "docker"];
    };
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
