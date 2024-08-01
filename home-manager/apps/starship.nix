{pkgs, ...}:
{

  home.packages = [ pkgs.starship ];
  programs.starship = {
    enable = true;
    presets = [ "nerd-font-symbols" ];
  };

}
