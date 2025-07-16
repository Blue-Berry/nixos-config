{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [
    dunst
    libnotify
    swww
    rofi-wayland
    networkmanagerapplet
    font-awesome
    blueman
    hyprpaper
    hyprlock
    playerctl
    grim
    slurp
    wl-clipboard
    qt6ct
    nwg-look
  ];
  imports = [
    ./waybar/default.nix
    # ./hyprpanel/default.nix
    (
      if userSettings.profile == "personal"
      then ./monitors/personal.nix
      else ./monitors/work.nix
    )
  ];
  services.hyprpaper.enable = true;
  # services.hyprpaper.settings = {
  #   wallpaper = [
  #     "HDMI-A-1, ${config.home.homeDirectory}/nixos-config/wallpapers/bh.jpg"
  #     "DP-2, ${config.home.homeDirectory}/nixos-config/wallpapers/bh-bright-close.jpg"
  #   ];
  #   preload = [
  #     "${config.home.homeDirectory}/nixos-config/wallpapers/bh.jpg"
  #     "${config.home.homeDirectory}/nixos-config/wallpapers/bh-bright-close.jpg"
  #   ];
  #   ipc = "off";
  #   splash = "false";
  # };

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    plugins = [
      # ... whatever
    ];
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    settings = {
      input = {
        accel_profile = "flat";
      };
      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = "4";
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
        };
        # drop_shadow = "yes";
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };
      general = {
        # "col.active_border" = lib.mkForce "rgba(74c7ecff)";
        gaps_in = 4;
        gaps_out = 8;
      };
      misc = {
        force_default_wallpaper = -1;
      };
      # monitor = [
      #   "eDP-2, 1920x1080, 0x0, 1"
      #   "DVI-I-1,1920x1080, 1280x0,1"
      #   "DVI-I-2,1920x1080, 3200x0,1"
      #   # Monitor eDP-2 (ID 0):
      #   # 	1920x1080@120.01500 at 0x0
      #   #
      #   # Monitor DVI-I-1 (ID 1):
      #   # 	1920x1080@60.00000 at 1280x0
      #   # # Monitor DVI-I-2 (ID 2):
      #   # 	1920x1080@60.00000 at 3200x0
      # ];
      # Execute your favorite apps at launch
      exec-once =
        [
          "swww & networkmanagerapplet & dunst & blueman-applet & waybar &"
          # "${pkgs.hyprpanel}/bin/hyprpanel"
          # "gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Ice"
        ]
        ++ (
          if userSettings.greeter == "hyprlock"
          then [
            "hyprlock || hyprctl dispatch exit"
          ]
          else []
        );

      # windowrulev2 = [
      #   "opacity 0.98 0.94,class:^zen$"
      # ];
      #
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "Ark";
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
        # "$mod, R, exec, $menu"
        # "$mod, R, exec, rofi -show drun -show-icons"
        "$mod, R, exec, rofi -show drun -theme $HOME/.config/rofi/launchers/type-5/style-4.rasi"
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

        # Example special workspace (scratchpad)
        # "$mod, S, togglespecialworkspace, magic"
        # "$mod SHIFT, S, movetoworkspace, special:magic"
        "$mod, F, fullscreen"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

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
          if userSettings.profile == "work"
          then [
            ",switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
            ",switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, 1920x1080, auto, 1\""
          ]
          else []
        );
      # env = [
      #   "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      # ];

      env =
        if userSettings.profile == "work"
        then [
          "AQ_DRM_DEVICES,/dev/dri/card3:/dev/dri/card0:/dev/dri/card2:/dev/dri/card1"
          # card0 => EVDI
          # card1 => NVIDIA
          # card2 => AMD
          # card3 => EVDI
        ]
        else [];

      workspace =
        if userSettings.profile == "personal"
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
      ];
      input = {
        natural_scroll = false;
        touchpad = {
          natural_scroll = true;
        };
      };
      cursor.no_hardware_cursors =
        if userSettings.profile == "personal"
        then false
        else true;
    };
  };
}
