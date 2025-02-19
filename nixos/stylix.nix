{pkgs, ...}: {
  stylix.image = ../wallpapers/earth.jpeg;
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.autoEnable = true;
}
