{
  lib,
  config,
  ...
}: let
  cfg = config.homeModules.envVars;
in {
  options.homeModules.envVars = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable home environment variables";
    };

    muProfile = lib.mkOption {
      type = lib.types.str;
      default = "personal";
      example = "work";
      description = "Default profile for mu tool";
    };

    editor = lib.mkOption {
      type = lib.types.str;
      default = "n";
      example = "nvim";
      description = "Default text editor command";
    };

    browser = lib.mkOption {
      type = lib.types.str;
      default = "zen-beta";
      example = "firefox";
      description = "Default web browser command";
    };

    terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
      example = "kitty";
      description = "Default terminal emulator command";
    };

    manpager = lib.mkOption {
      type = lib.types.str;
      default = "n +Man!";
      example = "nvim +Man!";
      description = "Default man page viewer command";
    };

    extraSessionPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["$HOME/.local/bin"];
      description = "Additional paths to add to session PATH";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = cfg.editor;
      BROWSER = cfg.browser;
      TERMINAL = cfg.terminal;
      MANPAGER = cfg.manpager;
      MU_PROFILE = cfg.muProfile;
    };

    home.sessionPath = ["$HOME/.config/emacs/bin/"] ++ cfg.extraSessionPaths;
  };
}
