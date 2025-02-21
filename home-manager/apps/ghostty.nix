{pkgs,lib, ...}: {
  home.packages = [pkgs.ghostty];
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      initial-command = "tmux";
      background-blur = true;
      window-decoration = "server";
    };
  };
}
