{pkgs, ...}: {
  imports = [
    ../nixos/stylix-common.nix
  ];
  stylix = {
    image = ../wallpapers/earth.jpeg;
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    autoEnable = true;
    opacity = {
      terminal = 0.8;
    };
    targets = {
      waybar.enable = false;
      hyprland.enable = true;
      spicetify.enable = false;
    };
  };
}
