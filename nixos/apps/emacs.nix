{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    libvterm
    emacsPackages.vterm
    binutils
    ripgrep
    fd
    zstd
    imagemagick
    age
    cmake
    libtool
    ispell
    emacs-git # Installs Emacs 28 + native-comp
  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs-git; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}
