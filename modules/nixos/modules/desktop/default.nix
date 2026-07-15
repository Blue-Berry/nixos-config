{ lib, ... }: {
  options.nixosModules.desktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all desktop group";
  };

  imports = [
    ./dms.nix
    ./gnome.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./kde.nix
    ./niri.nix
  ];
}
