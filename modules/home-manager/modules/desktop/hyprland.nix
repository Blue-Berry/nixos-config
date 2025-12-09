{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.homeModules.desktop.hyprland;
in {
  options.homeModules.desktop.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.homeModules.desktop.enable;
      defaultText = lib.literalExpression "config.homeModules.desktop.enable";
      description = "Enable Hyprland compositor configuration";
    };

    monitorProfile = lib.mkOption {
      type = lib.types.enum ["work" "personal" "custom"];
      default = "personal";
      description = "Configuration profile to use (affects workspaces, cursor, and other settings)";
    };

    input = {
      accelProfile = lib.mkOption {
        type = lib.types.enum ["flat" "adaptive"];
        default = "flat";
        description = "Mouse acceleration profile";
      };
    };

    decoration = {
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Corner rounding radius in pixels";
      };

      blur = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable blur effects";
        };

        size = lib.mkOption {
          type = lib.types.int;
          default = 5;
          description = "Blur size/radius";
        };

        passes = lib.mkOption {
          type = lib.types.int;
          default = 1;
          description = "Number of blur passes (more = stronger but slower)";
        };
      };
    };

    gaps = {
      inner = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Gap size between windows in pixels";
      };

      outer = lib.mkOption {
        type = lib.types.int;
        default = 8;
        description = "Gap size from screen edges in pixels";
      };
    };

    forceDefaultWallpaper = lib.mkOption {
      type = lib.types.int;
      default = -1;
      description = "Force default wallpaper (-1 = disabled, 0-2 = specific wallpaper)";
    };

    fileManager = lib.mkOption {
      type = lib.types.str;
      default = "Ark";
      description = "Default file manager application";
    };

    windowRules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["opacity 0.98 0.94,class:^zen$"];
      description = "Window rules (windowrulev2)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dunst
      libnotify
      swww
      rofi
      networkmanagerapplet
      font-awesome
      blueman
      hyprpaper
      hyprlock
      playerctl
      grim
      slurp
      wl-clipboard
      qt6Packages.qt6ct
      nwg-look
    ];

    stylix.targets.rofi.enable = true;
    services.hyprpaper.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
      plugins = [];
      systemd.enable = true;
      settings = let
        mod = "SUPER";
        terminal = config.homeModules.envVars.terminal or "ghostty";
        rofiTheme = ./rofi/style-4.rasi;
      in {
        "$mod" = mod;
        "$terminal" = terminal;
        "$fileManager" = cfg.fileManager;

        input = {
          accel_profile = cfg.input.accelProfile;
          natural_scroll = false;
          touchpad = {
            natural_scroll = true;
          };
        };

        decoration = {
          rounding = toString cfg.decoration.rounding;
          blur = {
            enabled = cfg.decoration.blur.enable;
            size = cfg.decoration.blur.size;
            passes = cfg.decoration.blur.passes;
          };
        };

        general = {
          gaps_in = cfg.gaps.inner;
          gaps_out = cfg.gaps.outer;
        };

        misc = {
          force_default_wallpaper = cfg.forceDefaultWallpaper;
        };

        exec-once = [
          "swww & networkmanagerapplet & dunst & blueman-applet & waybar &"
        ];

        windowrulev2 = cfg.windowRules;

        workspace =
          if cfg.monitorProfile == "personal"
          then [
            "1, monitor:DP-2, default:true"
            "2, monitor:HDMI-A-1, default:true"
          ]
          else [
            "1,monitor:DVI-I-1"
            "2,monitor:DVI-I-2"
            "3,monitor:HDMI-A-1"
          ];

        animation = [
          "windowsIn, 0, 8, default"
          "windows, 1, 8, default"
        ];

        cursor.no_hardware_cursors =
          if cfg.monitorProfile == "personal"
          then false
          else true;

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];

        bind = [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mod, T, exec, $terminal"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, E, exec, emacsclient --create-frame"
          "$mod, V, togglefloating,"
          "$mod, R, exec, rofi -show drun -theme ${rofiTheme}"
          "$mod, D, exec, $HOME/.config/rofi/powermenu/type-1/powermenu.sh"
          "$mod, P, pseudo, # dwindle"
          "$mod, J, togglesplit, # dwindle"

          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Switch workspaces with mod + [0-9]
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move active window to a workspace with mod + SHIFT + [0-9]
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          "$mod, F, fullscreen"

          # Scroll through existing workspaces with mod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # Screenshots
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "$mod, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        ];

        bindl =
          [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioPlay, exec, playerctl play-pause"
          ]
          ++ (
            if cfg.monitorProfile == "work"
            then [
              ",switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
              ",switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, 1920x1080, auto, 1\""
            ]
            else []
          );

        env =
          if cfg.monitorProfile == "work"
          then [
            "AQ_DRM_DEVICES,/dev/dri/card3:/dev/dri/card0:/dev/dri/card2:/dev/dri/card1"
          ]
          else [];
      };
    };
  };
}
