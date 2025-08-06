{
  pkgs,
  inputs,
  ...
}: let
  emacs = with pkgs;
    (emacsPackagesFor emacs-git-pgtk).emacsWithPackages (
      epkgs:
        with epkgs; [
          treesit-grammars.with-all-grammars
          vterm
          mu4e
          nixfmt
          apheleia
          ocp-indent
          ocamlformat
          merlin
          shfmt
          utop
          pinentry
          djvu
        ]
    );
  mkLauncherEntry = title: {
    prefix ? "launcher-",
    description ? "",
    icon,
    exec,
    categories ? [],
  }:
    pkgs.makeDesktopItem ({
        inherit icon exec categories;
        name = "${prefix}${builtins.hashString "md5" exec}";
        desktopName = title;
      }
      // (
        if description != ""
        then {
          genericName = description;
        }
        else {}
      ));
in {
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    (mkLauncherEntry "Emacs (Debug Mode)" {
      description = "Start Emacs in debug mode";
      icon = "emacs";
      exec = "${emacs}/bin/emacs --debug-init";
    })
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
    clang-tools
    texlive.combined.scheme-medium
    nixfmt-rfc-style
    emacs
    (aspellWithDicts (
      ds:
        with ds; [
          en
          en-computers
          en-science
        ]
    ))
  ];

  services.emacs = {
    enable = true;
    package = emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}
