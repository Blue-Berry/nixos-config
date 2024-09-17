{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autopair
    starship
  ];
  programs.zsh = {
    enable = true;
    #enableAutosuggestions = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    #enableLsColors = true;
    shellAliases = {
      ls = "exa --icons";
      ll = "exa --icons -l";
      la = "exa --icons -la";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "thefuck"
        "git"
        "npm"
        "history"
        "node"
        "rust"
        "deno"
      ];
      theme = "";
    };
  };
  # z
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi.enableZshIntegration = true;
  
  programs.zsh.initExtra = ''
    function y() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$tmp"
      if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }
  '';
}
