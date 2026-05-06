{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.homeModules.desktop.niri;
in {
  # imports = [
  #   inputs.niri.homeModules.niri
  # ];
  options.homeModules.desktop.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.homeModules.desktop.enable;
      defaultText = lib.literalExpression "config.homeModules.desktop.enable";
      description = "Enable Niri compositor configuration";
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

    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = [
        "HDMI-A-1"
        "DP-1"
        "eDP-1"
      ];
      description = "List of monitor names in order for Mod+<number> keybinds";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
      settings.main.font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=14";
    };
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock;
    };
    services.mako = {
      enable = true;
      settings = {
        default-timeout = 3000;
        ignore-timeout = false;
      };
    };

    services.swayidle.enable = true;
    services.polkit-gnome.enable = true;
    home.packages = with pkgs; [
      swaybg
      playerctl
    ];

    stylix.targets = {
      fuzzel.enable = true;
      swaylock.enable = true;
      mako.enable = true;
      niri.enable = true;
    };

    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.settings = {
      window-rules = [
        {
          geometry-corner-radius = let
            r = 0.0;
          in {
            bottom-left = r;
            bottom-right = r;
            top-left = r;
            top-right = r;
          };
          clip-to-geometry = true;
        }
        # {
        #   match = {
        #     app-id = "^com.mitchellh.ghostty$";
        #   };

        #   background-effect = {
        #     blur = true;
        #   };
        # }
      ];
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
        focus-follows-mouse.enable = true;
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
      in
        {
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

          # Brightness controls
          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = [
              "brightnessctl"
              "--class=backlight"
              "set"
              "+10%"
            ];
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = [
              "brightnessctl"
              "--class=backlight"
              "set"
              "10%-"
            ];
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
          "Mod+J".action.focus-window-or-workspace-down = [];
          "Mod+K".action.focus-window-or-workspace-up = [];
          "Mod+L".action.focus-column-right = [];

          # Move windows - Arrow keys
          "Mod+Ctrl+Left".action.move-column-left = [];
          "Mod+Ctrl+Down".action.move-window-down = [];
          "Mod+Ctrl+Up".action.move-window-up = [];
          "Mod+Ctrl+Right".action.move-column-right = [];

          # Move windows - Vim keys
          "Mod+Ctrl+H".action.move-column-left = [];
          "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [];
          "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [];
          "Mod+Ctrl+L".action.move-column-right = [];

          # Column navigation
          # "Mod+Home".action.focus-column-first = [];
          # "Mod+End".action.focus-column-last = [];
          # "Mod+Ctrl+Home".action.move-column-to-first = [];
          # "Mod+Ctrl+End".action.move-column-to-last = [];

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
          "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
          "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

          # Move workspace
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
          "Mod+Shift+1".action.focus-workspace = 1;
          "Mod+Shift+2".action.focus-workspace = 2;
          "Mod+Shift+3".action.focus-workspace = 3;
          "Mod+Shift+4".action.focus-workspace = 4;
          "Mod+Shift+5".action.focus-workspace = 5;
          "Mod+Shift+6".action.focus-workspace = 6;
          "Mod+Shift+7".action.focus-workspace = 7;
          "Mod+Shift+8".action.focus-workspace = 8;
          "Mod+Shift+9".action.focus-workspace = 9;

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
          # "Mod+Comma".action.consume-window-into-column = [];
          # "Mod+Period".action.expel-window-from-column = [];
          "Mod+Shift+BracketLeft".action.consume-window-into-column = [];
          "Mod+Shift+BracketRight".action.expel-window-from-column = [];

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

          # Tabbed display / Wallpaper carousel (DMS)

          # Keyboard layout switching
          # "Mod+Space".action.switch-layout = "next";
          # "Mod+Shift+Space".action.switch-layout = "prev";

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
        }
        // lib.optionalAttrs config.homeModules.desktop.dms {
          "Mod+D" = lib.mkForce {
            action.spawn = [
              "dms"
              "ipc"
              "spotlight"
              "toggle"
            ];
            hotkey-overlay.title = "Toggle Spotlight";
          };
          "Mod+W" = {
            action.spawn = [
              "dms"
              "ipc"
              "wallpaperCarousel"
              "toggle"
            ];
            hotkey-overlay.title = "Wallpaper Carousel toggle";
          };
          "Mod+P" = {
            action.spawn = [
              "dms"
              "ipc"
              "clipboard"
              "toggle"
            ];
            hotkey-overlay.title = "Toggle Clipboard Manager";
          };
          "Super+Alt+L" = lib.mkForce {
            action.spawn = [
              "dms"
              "ipc"
              "lock"
              "lock"
            ];
            hotkey-overlay.title = "Toggle Lock Screen";
          };
        }
        # Generate monitor focus keybinds dynamically
        // (lib.listToAttrs (
          lib.imap0 (
            idx: monitor:
              lib.nameValuePair "Mod+${toString (idx + 1)}" {
                action = sh "niri msg action focus-monitor '${monitor}'";
              }
          )
          cfg.monitors
        ))
        # Generate move column to monitor keybinds dynamically
        // (lib.listToAttrs (
          lib.imap0 (
            idx: monitor:
              lib.nameValuePair "Mod+Shift+Ctrl+${toString (idx + 1)}" {
                action = sh "niri msg action move-column-to-monitor '${monitor}'";
              }
          )
          cfg.monitors
        ));
    };
  };
}
