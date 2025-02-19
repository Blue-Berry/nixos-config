{pkgs, ...}: {
  stylix = {
    image = ../wallpapers/earth.jpeg;
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    autoEnable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hasklug;
        name = "Hasklug Nerd Font Mono";
      };
      sizes = {
        terminal = 10;
      };
    };
  };
}
