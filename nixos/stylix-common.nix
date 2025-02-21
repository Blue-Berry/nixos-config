{pkgs, ...}: {
  stylix = {
    image = ../wallpapers/black_hole_horizon_3840x2160.jpg;
    enable = true;
    polarity = "dark";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    autoEnable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.hello;
        name = "Hasklug Nerd Font Mono";
      };
      emoji = {
        package = pkgs.hello;
        name = "Hasklug Nerd Font Mono";
      };
      sizes = {
        terminal = 10;
      };
    };
  };
}
