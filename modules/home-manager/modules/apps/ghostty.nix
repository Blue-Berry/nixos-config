{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.ghostty;
in
{
  options.homeModules.apps.ghostty = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Ghostty terminal emulator";
  };

  config = lib.mkIf cfg {
    home.packages = [ pkgs.ghostty ];
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        initial-command = "tmux";
        background-blur = true;
        background-opacity = 0.7;
        # window-decoration = "server";
        window-decoration = "none";
        app-notifications = "false";
        confirm-close-surface = false;
        shell-integration-features = "ssh-terminfo,ssh-env";
      };
    };
  };
}
