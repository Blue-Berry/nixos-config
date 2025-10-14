{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.zsh
    pkgs.git
    pkgs.usbutils
    pkgs.perf
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.nmap
    pkgs.cachix
  ];
}
