{pkgs,lib, ...}: {
  home.packages = [pkgs.ghostty];
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # font-family = lib.mkForce "Source Code Pro";
      # font-family = lib.mkForce "Hasklug Nerd Font Mono";
# Hasklug Nerd Font Mono
    };
  };
}
