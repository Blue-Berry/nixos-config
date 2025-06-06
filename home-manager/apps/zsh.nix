{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-autopair
    starship
  ];
  # TODO: config ctrl-p to mimic up arrow, ctrl-n to mimic down arrow and ctrl-y to accept completeions
  programs = {
    zsh = {
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
        tree = "exa --icons --tree --level 3";
        lr = "exa --icons --recurse --level 3";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "npm"
          "history"
          "node"
          "rust"
          "deno"
          "vi-mode"
        ];
        theme = "";
      };
      # for yazi
      initContent = ''
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }

        bindkey "^Y" autosuggest-accept
        bindkey '^p' down-line-or-beginning-search
        bindkey '^n' up-line-or-beginning-search

      '';
    };
    # z
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
