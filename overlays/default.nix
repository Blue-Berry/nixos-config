# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # opam = inputs.nix-ocaml-overlay.legacyPackages.${final.system}.opam;

    # Override janet-lsp to use Blue-Berry/janet-lsp.nix package
    janet-lsp =
      let
        src = inputs.janet-lsp-nix;
        expr = src + "/default.nix";
      in
      prev.callPackage expr { };

    dune_3 = prev.dune_3.overrideAttrs (old: rec {
      version = "dev";
      src = inputs."dune-src";
    });
    dune = final.dune_3;
  };

  # hyprpanel = inputs.hyprpanel.overlay;

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  # Overlay to expose pkgs.codex from our local derivation
  codex = final: prev: {
    codex = prev.callPackage ../pkgs/codex { };
  };
}
