{lib, ...}: {
  options.homeModules.desktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all desktop group";
  };

  imports = [
    ./dconf.nix
    ./hyprland.nix
    ./niri.nix
    ./waybar.nix
  ];
}
