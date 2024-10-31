{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.zsh
    pkgs.git
    pkgs.usbutils
  ];
}
