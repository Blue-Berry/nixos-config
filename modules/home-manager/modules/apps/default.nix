{lib, ...}: {
  options.homeModules.apps.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all apps group";
  };

  imports = [
    ./anki.nix
    ./delta.nix
    ./direnv.nix
    ./ghostty.nix
    ./git.nix
    ./gitui.nix
    ./kitty.nix
    ./neovide.nix
    ./nushell.nix
    ./nvim.nix
    ./opencode.nix
    ./spotify.nix
    ./starship.nix
    ./thunderbird.nix
    ./vivid.nix
    ./yazi.nix
    ./zathura.nix
    ./zsh.nix
  ];
}
