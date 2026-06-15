{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.nixosModules.greeter.dankGreeter;
  # Needed to fix a bug when starting dms-greeter (should remove when fixed)
  niriGreeterConfig = ''
    hotkey-overlay {
      skip-at-startup
    }

    environment {
      DMS_RUN_GREETER "1"
    }

    gestures {
      hot-corners {
        off
      }
    }

    layout {
      background-color "#000000"
    }
  '';
in {
  imports = [
    inputs.dms.nixosModules.greeter
  ];

  options.nixosModules.greeter.dankGreeter = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable DankGreeter";
    };

    compositor = lib.mkOption {
      type = lib.types.str;
      default = "niri";
      description = "Compositor to use (niri, hyprland, sway)";
    };

    username = lib.mkOption {
      type = lib.types.str;
      default = "liam";
      description = "Username for greeter config home";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.dank-material-shell.greeter = {
      enable = true;
      compositor = {
        name = cfg.compositor;
        customConfig = lib.mkIf (cfg.compositor == "niri") niriGreeterConfig;
      };
      configHome = "/home/${cfg.username}";
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };
  };
}
