{
  pkgs,
  inputs,
  ...
}:
let
  emacs =
    with pkgs;
    (emacsPackagesFor (emacs-git-pgtk)).emacsWithPackages (
      epkgs: with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
        mu4e
        nixfmt
        apheleia
      ]
    );
in
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    libvterm
    binutils
    ripgrep
    fd
    zstd
    imagemagick
    age
    cmake
    libtool
    ispell
    pandoc
    sqlite
    clang-tools
    texlive.combined.scheme-medium
    emacs
  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs-git; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}
