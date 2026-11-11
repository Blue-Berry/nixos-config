{
  dendritic.home.commonPackages = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        home.packages = with pkgs; [
          # Ocaml
          bubblewrap # For opam
          ocamlPackages.findlib
          # ocamlPackages.magic-trace
          opam
          dune_3

          # Nix
          nil
          nixd
          statix
          alejandra
          nixfmt
          nixfmt-tree

          # Other
          gcc
          # gleam
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

          typst
        ];
      };
    }
  );
}
