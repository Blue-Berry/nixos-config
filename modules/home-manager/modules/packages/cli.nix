{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.packages.cli;
in
{
  options.homeModules.packages.cli = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.packages.enable;
    defaultText = lib.literalExpression "config.homeModules.packages.enable";
    description = "Enable CLI utility packages";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      bat
      bottom
      dig
      doggo
      duf
      dust
      eza
      fd
      ffmpeg
      gping
      git-commit-ai
      gh
      fzf
      hyperfine
      iputils
      perf
      ncdu
      codex
      ripgrep
      rsync
      sshfs
      starship
      tealdeer
      tmux
      tokei
      unzip
      wget
      zip
      zoxide
      nix-output-monitor
      inotify-tools
      jq
      unixtools.netstat
      nh
      wl-clipboard
    ];
  };
}
