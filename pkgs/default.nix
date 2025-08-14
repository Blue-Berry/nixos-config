# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  wooting-udev = pkgs.callPackage ./wooting-udev {};
  gowin-udev = pkgs.callPackage ./gowin-udev {};
  gowin-ide = pkgs.callPackage ./gowin {};
  gowin-edu = pkgs.callPackage ./gowin-edu {};
  showcolors = pkgs.callPackage ./showcolors {};
  swe-agent = pkgs.callPackage ./swe-agent {};
  swe-rex = pkgs.callPackage ./swe-rex {};
  git-commit-ai = pkgs.callPackage ./git-commit-ai {};
  nix-mu = pkgs.callPackage ./mu {};
  janet-lsp = pkgs.callPackage ./janet-lsp {};
}
