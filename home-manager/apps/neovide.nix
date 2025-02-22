{pkgs, ...}: {
  home.packages = [pkgs.neovide];
  programs.neovide = {
    enable = true;
    settings = {
      neovim-bin = "n";
    };
  };
}
