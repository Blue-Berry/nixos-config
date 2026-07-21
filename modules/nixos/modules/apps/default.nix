{ lib, ... }: {
  options.nixosModules.apps.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all apps group";
  };

  imports = [
    ./cachix-agent.nix
    ./emacs.nix
    ./kanata.nix
    ./localsend.nix
    ./nvim.nix
    ./ollama.nix
    ./pass.nix
    ./starship.nix
    ./steam.nix
    ./wireguard.nix
    ./zsh.nix
    ./platformio.nix
    ./gnome-calendar.nix
  ];
}
