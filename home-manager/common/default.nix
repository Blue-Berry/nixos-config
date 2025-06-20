{...}: {
  imports = [
    ../apps/delta.nix
    ../apps/direnv.nix
    ../apps/git.nix
    ../apps/kitty.nix
    ../apps/ghostty.nix
    ../apps/spotify.nix
    ../apps/starship.nix
    ../apps/yazi/yazi.nix
    ../apps/zsh.nix
    ../apps/neovide.nix
    ../apps/zathura.nix

    ../env-vars.nix
    ../packages.nix
    ../stylix.nix

    ../desktop/dconf.nix
    ../../overlays/enable.nix
  ];

  programs.neovim.enable = true;
}
