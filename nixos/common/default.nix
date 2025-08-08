{
  outputs,
  config,
  lib,
  ...
}: {
  imports = [
    ../../overlays/enable.nix
    ../packages/default.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    ../flake-options.nix
    ../fonts.nix
    ../containers.nix
    ../hardware/wooting.nix
    ../hardware/ntfs.nix
    ../hardware/logic-analyzer.nix
    # ../apps/nvim.nix
    ../apps/wireguard.nix
    ../ports.nix
    ../stylix.nix
    ../system/gc.nix
    ../preload.nix
    ../apps/emacs.nix
    ../apps/pass.nix

    ../boot.nix
    outputs.nixosModules.conditional-imports
  ];
  services.cachix-agent.enable = true;
  nix.settings.trusted-users = [
    "root"
    "liam"
  ];
  networking.nameservers = [
    "10.64.0.1"
    "grovewalk.duckdns.org"
    "1.1.1.1"
    "8.8.8.8"
  ];
}
