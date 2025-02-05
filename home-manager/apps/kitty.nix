{pkgs, ...}: {
  home.packages = [pkgs.kitty];
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      # name = "FiraCode Nerd Font Mono";
      name = "Hasklug Nerd Font Mono";
      size = 10;
    };
    settings = {
      background_opacity = "0.8";
      enable_audio_bell = false;
    };
  };
}
