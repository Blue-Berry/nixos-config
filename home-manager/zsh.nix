{pkgs, ...}:
{
  home.packages = with pkgs; [
    zsh
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autopair

    starship
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    enableLsColors = true;
  };
}
