{pkgs, ...}: {
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
    jpm
    gleam
    gmp
    gnumake
    go
    janet
    janet-lsp
    lazydocker
    lazygit
    lua-language-server
    nodejs
    postman
    python3
    rustup
  ];
}
