{pkgs, inputs, ...}: {
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlays.default
  ];

  environment.systemPackages = [
    pkgs.emacs-git # Installs Emacs 28 + native-comp
  ];
}
