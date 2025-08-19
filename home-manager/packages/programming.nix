{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
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
    nil
    nixd
    nodejs
    ocamlPackages.findlib
    ocamlPackages.magic-trace
    opam
    postman
    python3
    rustup
    statix
  ];
}
