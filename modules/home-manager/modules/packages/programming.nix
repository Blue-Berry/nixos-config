{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.packages.programming;
in {
  options.homeModules.packages.programming = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.packages.enable;
    defaultText = lib.literalExpression "config.homeModules.packages.enable";
    description = "Enable programming language packages and tools";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      # Ocaml
      bubblewrap # For opam
      ocamlPackages.findlib
      ocamlPackages.magic-trace
      opam
      dune_3

      # Nix
      nil
      nixd
      statix
      alejandra

      # Other
      gcc
      gleam
      gmp
      gnumake
      go
      lazydocker
      lazygit
      lua-language-server
      nodejs
      postman
      python3
      rustup
      arduino-ide
      prettier
    ];
  };
}
