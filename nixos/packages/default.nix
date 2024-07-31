{pkgs, ...}:
{
  environment.systemPackages = 
  [ 
    pkgs.stable.vim
    pkgs.wget
    pkgs.zsh
    pkgs.git
  ];
}
