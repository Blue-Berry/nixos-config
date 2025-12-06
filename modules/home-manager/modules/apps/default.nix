{lib, ...}: {
  options.homeModules.apps.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all apps group";
  };

  imports = [
    ./delta.nix
    ./direnv.nix
    ./ghostty.nix
    ./git.nix
    ./kitty.nix
    ./neovide.nix
    ./nushell.nix
    ./nvim.nix
    ./opencode.nix
    ./spotify.nix
    ./starship.nix
    ./vivid.nix
    ./yazi.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
