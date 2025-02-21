{
  pkgs,
  ...
}: {
  home.packages = [pkgs.ghostty];
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };
}
