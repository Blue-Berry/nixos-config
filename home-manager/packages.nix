{pkgs, ...}:
{

  home.packages = with pkgs; [
    zsh
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autopair

  ];
}
