{pkgs, ... }: {

  home.packages = [ pkgs.kitty ];
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 10;
    };
    settings = {
      background_opacity = "0.8";
    };
  };
}
