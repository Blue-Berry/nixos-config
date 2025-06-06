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

        source $ZSH/oh-my-zsh.sh

        PROMPT="$PROMPT\$(vi_mode_prompt_info)"
        RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

        bindkey "^Y" autosuggest-accept
        bindkey -M vicmd "^N" up-history
        bindkey -M vicmd "^P" down-history
        bindkey -M viins '^P' down-line-or-beginning-search
        bindkey -M viins '^N' up-line-or-beginning-search
      '';
    };
    # z
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
