{lib, ...}: {
  options.nixosModules.desktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all desktop group";
  };

  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./kde.nix
    ./niri.nix
  ];
}
