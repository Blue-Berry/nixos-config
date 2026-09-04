{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.nixosModules.apps.emacs;

  emacs =
    with pkgs;
    (emacsPackagesFor emacs-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        # treesit-grammars.with-all-grammars
        vterm
        nixfmt
        apheleia
        ocp-indent
        ocamlformat
        merlin
        shfmt
        utop
        djvu
        flymake-golangci
        flycheck-golangci-lint
        gnuplot
        mu4e
        pdf-tools
      ]
    );

  mkLauncherEntry =
    title:
    {
      prefix ? "launcher-",
      description ? "",
      icon,
      exec,
      categories ? [ ],
    }:
    pkgs.makeDesktopItem (
      {
        inherit icon exec categories;
        name = "${prefix}${builtins.hashString "md5" exec}";
        desktopName = title;
      }
      // (
        if description != "" then
          {
            genericName = description;
          }
        else
          { }
      )
    );
in
{
  options.nixosModules.apps.emacs = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable Emacs with custom configuration";
  };

  config = lib.mkIf cfg {
    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      (mkLauncherEntry "Emacs (Debug Mode)" {
        description = "Start Emacs in debug mode";
        icon = "emacs";
        exec = "${emacs}/bin/emacs --debug-init";
      })
      pkg-config
      openssl
      asm-lsp
      libvterm
      binutils
      ripgrep
      fd
      zstd
      imagemagick
      age
      cmake
      graphviz
      scrot
      libtool
      ispell
      pandoc
      sqlite
      symbola
      clang-tools
      gnuplot
      # for lsp booster
      emacs-lsp-booster
      texlive.combined.scheme-medium
      nixfmt-rfc-style
      emacs
      golangci-lint
      # wuzapi backend for wasabi (WhatsApp client)
      wuzapi
      # For image preview
      vips
      (aspellWithDicts (
        ds: with ds; [
          en
          en-computers
          en-science
        ]
      ))
    ];

    services.emacs = {
      enable = true;
      package = emacs;
    };
  };
}
