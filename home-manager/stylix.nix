{pkgs, ...}: {
  imports = [
    ../nixos/stylix-common.nix
  ];
  stylix = {
    opacity = {
      terminal = 0.8;
    };
    targets = {
      hyprland.enable = true;
      waybar.enable = false;
      spicetify.enable = false;
    };
  };
}
