# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ../../home-manager/packages.nix
    ../../overlays/enable.nix
    ../../home-manager/env-vars.nix
    ../../home-manager/apps/git.nix
    ../../home-manager/apps/kitty.nix
    ../../home-manager/apps/zsh.nix
    ../../home-manager/apps/starship.nix
    ../../home-manager/apps/direnv.nix
    ../../home-manager/apps/nix-colors.nix
    ../../home-manager/apps/yazi/yazi.nix

    # ./desktop/hyprland/hyprland.nix
  ];

    home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".tmux.conf".source = ../dots/tmux.conf;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05"; # Did you read the comment?
}
