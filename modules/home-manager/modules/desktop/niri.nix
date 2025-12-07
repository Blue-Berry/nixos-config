{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.desktop.niri;
in {
  options.homeModules.desktop.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.homeModules.desktop.enable;
      defaultText = lib.literalExpression "config.homeModules.desktop.enable";
      description = "Enable Niri compositor configuration";
    };

    outputs = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          position = lib.mkOption {
            type = lib.types.submodule {
              options = {
                x = lib.mkOption { type = lib.types.int; };
                y = lib.mkOption { type = lib.types.int; };
              };
            };
            description = "Output position";
          };
        };
      });
      default = {};
      example = {
        "DP-1" = { position = { x = 0; y = 0; }; };
        "HDMI-A-1" = { position = { x = 1920; y = 0; }; };
      };
      description = "Monitor output configurations";
    };

    terminal = lib.mkOption {
      type = lib.types.str;
      default = config.homeModules.envVars.terminal or "ghostty";
      defaultText = lib.literalExpression "config.homeModules.envVars.terminal";
      description = "Terminal emulator command for Mod+T";
    };

    launcher = lib.mkOption {
      type = lib.types.str;
      default = "fuzzel";
      example = "rofi -show drun";
      description = "Application launcher command for Mod+D";
    };

    screenshotPath = lib.mkOption {
      type = lib.types.str;
      default = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      description = "Path pattern for screenshots";
    };

    layout = {
      gaps = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Gap size between windows in pixels";
      };

      focusRingWidth = lib.mkOption {
        type = lib.types.float;
        default = 1.3;
        description = "Width of the focus ring";
      };
    };

    input = {
      numlockEnable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable numlock by default";
      };

      touchpad = {
        tap = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable tap to click on touchpad";
        };

        naturalScroll = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable natural scrolling on touchpad";
        };
      };

      warpMouseToFocus = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Warp mouse cursor to focused window";
      };
    };

    animations = {
      slowdown = lib.mkOption {
        type = lib.types.float;
        default = 0.9;
        description = "Animation slowdown multiplier (lower = faster)";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
    };
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock;
    };
    services.mako.enable = true;
    services.swayidle.enable = true;
    services.polkit-gnome.enable = true;
    home.packages = with pkgs; [
      swaybg
    ];

    stylix.targets = {
      fuzzel.enable = true;
      swaylock.enable = true;
      mako.enable = true;
      niri.enable = true;
    };

    programs.niri.settings = {
      outputs = cfg.outputs;
      spawn-at-startup = [
        {command = ["waybar"];}
      ];
      input = {
        keyboard.numlock = cfg.input.numlockEnable;
        touchpad = {
          tap = cfg.input.touchpad.tap;
          natural-scroll = cfg.input.touchpad.naturalScroll;
        };
        warp-mouse-to-focus.enable = cfg.input.warpMouseToFocus;
      };
      layout = {
        gaps = cfg.layout.gaps;
        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];
        focus-ring.width = cfg.layout.focusRingWidth;
        border.enable = false;
      };
      animations.slowdown = cfg.animations.slowdown;
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = cfg.screenshotPath;
      binds = let
        # Helper to create spawn-sh actions
        sh = cmd: {spawn-sh = cmd;};
      in {
        # Show hotkey overlay
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];

        # Core application launches
        "Mod+T".action.spawn = cfg.terminal;
        "Mod+D".action.spawn = cfg.launcher;
        "Super+Alt+L".action.spawn = "swaylock";

        # Volume controls
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        # Media controls
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action = sh "playerctl play-pause";
        };
        "XF86AudioStop" = {
          allow-when-locked = true;
          action = sh "playerctl stop";
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action = sh "playerctl previous";
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action = sh "playerctl next";
        };

        # Brightness controls
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];
        };

        # Overview
        "Mod+O".action.toggle-overview = [];

        # Window management
        "Mod+Q".action.close-window = [];

        # Focus navigation - Arrow keys
        "Mod+Left".action.focus-column-left = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+Right".action.focus-column-right = [];

        # Focus navigation - Vim keys
        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];

        # Move windows - Arrow keys
        "Mod+Ctrl+Left".action.move-column-left = [];
        "Mod+Ctrl+Down".action.move-window-down = [];
        "Mod+Ctrl+Up".action.move-window-up = [];
        "Mod+Ctrl+Right".action.move-column-right = [];

        # Move windows - Vim keys
        "Mod+Ctrl+H".action.move-column-left = [];
        "Mod+Ctrl+J".action.move-window-down = [];
        "Mod+Ctrl+K".action.move-window-up = [];
        "Mod+Ctrl+L".action.move-column-right = [];

        # Column navigation
        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];

        # Monitor focus - Arrow keys
        "Mod+Shift+Left".action.focus-monitor-left = [];
        "Mod+Shift+Down".action.focus-monitor-down = [];
        "Mod+Shift+Up".action.focus-monitor-up = [];
        "Mod+Shift+Right".action.focus-monitor-right = [];

        # Monitor focus - Vim keys
        "Mod+Shift+H".action.focus-monitor-left = [];
        "Mod+Shift+J".action.focus-monitor-down = [];
        "Mod+Shift+K".action.focus-monitor-up = [];
        "Mod+Shift+L".action.focus-monitor-right = [];

        # Move column to monitor - Arrow keys
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];

        # Move column to monitor - Vim keys
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

        # Workspace navigation
        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+U".action.focus-workspace-down = [];
        "Mod+I".action.focus-workspace-up = [];

        # Move column to workspace
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

        # Move workspace
        "Mod+Shift+Page_Down".action.move-workspace-down = [];
        "Mod+Shift+Page_Up".action.move-workspace-up = [];
        "Mod+Shift+U".action.move-workspace-down = [];
        "Mod+Shift+I".action.move-workspace-up = [];

        # Mouse wheel workspace navigation
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = [];
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = [];
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = [];
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = [];
        };

        # Mouse wheel column navigation
        "Mod+WheelScrollRight".action.focus-column-right = [];
        "Mod+WheelScrollLeft".action.focus-column-left = [];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];

        # Mouse wheel with Shift
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];

        # Workspace by number - focus
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        # Workspace by number - move column
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        # Column consume/expel
        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];
        "Mod+Comma".action.consume-window-into-column = [];
        "Mod+Period".action.expel-window-from-column = [];

        # Window/column sizing
        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [];
        "Mod+C".action.center-column = [];
        "Mod+Ctrl+C".action.center-visible-columns = [];

        # Fine-grained width adjustments
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Fine-grained height adjustments
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Floating windows
        "Mod+V".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

        # Tabbed display
        "Mod+W".action.toggle-column-tabbed-display = [];

        # Keyboard layout switching
        "Mod+Space".action.switch-layout = "next";
        "Mod+Shift+Space".action.switch-layout = "prev";

        # Mouse bindings
        "Mod+MouseMiddle".action.close-window = [];

        # Screenshots
        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];

        # System controls
        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [];
        };
        "Mod+Shift+E".action.quit = [];
        "Ctrl+Alt+Delete".action.quit = [];
        "Mod+Shift+P".action.power-off-monitors = [];
      };
    };
  };
}
