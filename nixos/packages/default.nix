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
    pkgs.linuxPackages_latest.perf
  ];
}
