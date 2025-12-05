{pkgs, ...}: {
  imports = [./janet.nix];
  home.packages = with pkgs; [
    # Ocaml
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
}
