{pkgs, ...}: {
  imports = [
    ../nixos/stylix-common.nix
  ];
  stylix = {
    opacity = {
      terminal = 0.8;
    };
    targets = {
      yazi.enable = true;
      bat.enable = true;
      btop.enable = true;
      hyprland.enable = true;
      waybar.enable = false;
      spicetify.enable = false;
    };
  };
}
