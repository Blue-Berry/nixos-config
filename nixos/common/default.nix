{...}: {
  imports = [
    ../../overlays/enable.nix
    ../packages/default.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    ../flake-options.nix
    ../fonts.nix
    ../containers.nix
    ../hardware/solaar.nix
    ../hardware/ratbag.nix
    ../hardware/wooting.nix
    ../hardware/ntfs.nix
    ../hardware/logic-analyzer.nix
    # ../apps/nvim.nix
    ../apps/wireguard.nix
    ../ports.nix
    ../stylix.nix
    ../desktop/hyprland/default.nix
    ../desktop/gdm/default.nix
    # ./desktop/kde/default.nix
    ../desktop/gnome/default.nix
    ../system/gc.nix
    ../preload.nix
    ../apps/emacs.nix
    ../apps/pass.nix

    ../boot.nix
  ];
  services.cachix-agent.enable = true;
  nix.settings.trusted-users = [
    "root"
    "liam"
  ];
}
