{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];
  programs.fuzzel = {
    enable = true; # Super+D in the default setting (app launcher)
    package = pkgs.fuzzel;
  };
  programs.swaylock = {
    enable = true; # Super+Alt+L in the default setting (screen locker)
    package = pkgs.swaylock;
  };
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  home.packages = with pkgs; [
    swaybg # wallpaper
  ];
  # xdg.configFile."niri/config.kdl".source = ./config.kdl;

  stylix.targets = {
    fuzzel.enable = true;
    swaylock.enable = true;
    mako.enable = true;
    niri.enable = true;
  };
  # https://github.com/sodiboo/niri-flake/blob/main/docs.md
  programs.niri.settings = {
    # TODO: make this dynamic
    outputs."DVI-I-1" = {
      position.x = 0;
      position.y = 0;
    };
    outputs."DVI-I-2" = {
      position.x = 1920;
      position.y = 0;
    };
    outputs."HDMI-A-1" = {
      position.x = 3840;
      position.y = 0;
    };
    input = {
      keyboard.numlock = true;
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
      warp-mouse-to-focus.enable = true;
    };
    layout = {
      gaps = 10;
      preset-column-widths = [
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
        # { fixed = 1920; }
      ];
      focus-ring = {
        width = 1.3;
      };
      border.enable = false;
      # shadow
      # TODO: Window rules
    };
    animations.slowdown = 0.9;
    hotkey-overlay.skip-at-startup = true;

    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [];

      "Mod+T" = {
        hotkey-overlay.title = "Open a Terminal: ghostty";
        action.spawn = "ghostty";
      };
      "Mod+D" = {
        hotkey-overlay.title = "Run an Application: fuzzel";
        action.spawn = "fuzzel";
      };
      "Super+Alt+L" = {
        hotkey-overlay.title = "Lock the Screen: swaylock";
        action.spawn = "swaylock";
      };

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
      "XF86AudioPlay" = {
        allow-when-locked = true;
        action.spawn-sh = "playerctl play-pause";
      };
      "XF86AudioStop" = {
        allow-when-locked = true;
        action.spawn-sh = "playerctl stop";
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action.spawn-sh = "playerctl previous";
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action.spawn-sh = "playerctl next";
      };

      # XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
      # XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

      "Mod+O" = {
        repeat = false;
        action.toggle-overview = [];
      };

      "Mod+Q" = {
        repeat = false;
        action.close-window = [];
      };

      "Mod+Left".action.focus-column-left = [];
      "Mod+Down".action.focus-window-down = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+H".action.focus-column-left = [];
      "Mod+J".action.focus-window-or-workspace-down = [];
      "Mod+K".action.focus-window-or-workspace-up = [];
      "Mod+L".action.focus-column-right = [];

      "Mod+Ctrl+Left".action.move-column-left = [];
      "Mod+Ctrl+Down".action.move-window-down = [];
      "Mod+Ctrl+Up".action.move-window-up = [];
      "Mod+Ctrl+Right".action.move-column-right = [];
      "Mod+Ctrl+H".action.move-column-left = [];
      "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [];
      "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [];
      "Mod+Ctrl+L".action.move-column-right = [];

      "Mod+Home".action.focus-column-first = [];
      "Mod+End".action.focus-column-last = [];
      "Mod+Ctrl+Home".action.move-column-to-first = [];
      "Mod+Ctrl+End".action.move-column-to-last = [];

      "Mod+Shift+Left".action.focus-monitor-left = [];
      "Mod+Shift+Down".action.focus-monitor-down = [];
      "Mod+Shift+Up".action.focus-monitor-up = [];
      "Mod+Shift+Right".action.focus-monitor-right = [];
      "Mod+Shift+H".action.focus-monitor-left = [];
      "Mod+Shift+J".action.focus-monitor-down = [];
      "Mod+Shift+K".action.focus-monitor-up = [];
      "Mod+Shift+L".action.focus-monitor-right = [];

      "Mod+Shift+Ctrl+Left".action.move-workspace-to-monitor-left = [];
      "Mod+Shift+Ctrl+Down".action.move-workspace-to-monitor-down = [];
      "Mod+Shift+Ctrl+Up".action.move-workspace-to-monitor-up = [];
      "Mod+Shift+Ctrl+Right".action.move-workspace-to-monitor-right = [];
      "Mod+Shift+Ctrl+H".action.move-workspace-to-monitor-left = [];
      "Mod+Shift+Ctrl+J".action.move-workspace-to-monitor-down = [];
      "Mod+Shift+Ctrl+K".action.move-workspace-to-monitor-up = [];
      "Mod+Shift+Ctrl+L".action.move-workspace-to-monitor-right = [];

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "Mod+BracketLeft".action.consume-or-expel-window-left = [];
      "Mod+BracketRight".action.consume-or-expel-window-right = [];

      "Mod+Comma".action.consume-window-into-column = [];
      "Mod+Period".action.expel-window-from-column = [];
      "Mod+R".action.switch-preset-column-width = [];

      "Mod+Shift+R".action.switch-preset-window-height = [];
      "Mod+Ctrl+R".action.reset-window-height = [];
      "Mod+F".action.maximize-column = [];
      "Mod+Shift+F".action.fullscreen-window = [];

      "Mod+C".action.center-column = [];
      "Mod+Ctrl+C".action.center-visible-columns = [];

      "Mod+V".action.toggle-window-floating = [];
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

      "Mod+W".action.toggle-column-tabbed-display = [];

      "Print".action.screenshot = [];
      "Ctrl+Print".action.screenshot-screen = [];
      "Alt+Print".action.screenshot-window = [];

      "Mod+Shift+E".action.quit = [];
      "Ctrl+Alt+Delete".action.quit = [];

      "Mod+Shift+P".action.power-off-monitors = [];
    };
    # switch-events.lid-close
  };
}
