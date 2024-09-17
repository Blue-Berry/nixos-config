{pkgs, ...}: {
  home.packages = with pkgs; [
    yazi
  ];

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
