{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.desktop.waybar;
in {
  options.homeModules.desktop.waybar = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.desktop.enable;
    defaultText = lib.literalExpression "config.homeModules.desktop.enable";
    description = "Enable Waybar status bar";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      mpc
      waybar
      pamixer
      ddcutil
    ];

    programs.waybar = {
      enable = true;

      settings = [
        {
          "layer" = "top";
          "position" = "top";

          margin-top = 5;
          margin-left = 10;
          margin-right = 10;
          height = 20;
          modules-left = ["hyprland/workspaces" "niri/workspaces"];
          modules-center = ["hyprland/window" "niri/window" "gamemode"];
          modules-right = [
            "group/trayG"
            "battery"
            "pulseaudio"
            "backlight"
            "group/comms"
            "group/usage"
            "group/clockG"
          ];
          "hyprland/workspaces" = {
            "format" = "{icon}";
            "on-click" = "activate";
          };
          "hyprland/window" = {
            "format" = "{}";
            "max-length" = 35;
            "rewrite" = {
              "" = "Hyprland";
            };
            separate-outputs = true;
          };
          "niri/workspaces" = {
            "format" = "{icon}";
          };
          "niri/window" = {
            "format" = "{}";
            "max-length" = 35;
            "rewrite" = {
              "" = "Niri";
            };
            separate-outputs = true;
          };
          "group/usage" = {
            "orientation" = "horizontal";
            "modules" = ["cpu" "memory" "temperature"];
          };
          "group/clockG" = {
            "orientation" = "horizontal";
            "modules" = ["clock"];
          };
          "group/trayG" = {
            "orientation" = "horizontal";
            "modules" = ["tray"];
          };
          "group/comms" = {
            "orientation" = "horizontal";
            "modules" = ["network" "bluetooth"];
          };
          "backlight" = {
            "format" = "{icon} {percent}%";
            "format-icons" = ["󰃝" "󰃞" "󰃟" "󰃠"];
          };
          "pulseaudio" = {
            "scroll-step" = 1;
            "format" = "{icon}   {volume}%";
            "format-muted" = "󰖁 Muted";
            "format-icons" = {
              "default" = ["" "" ""];
            };
            "on-click" = "pamixer -t";
            "tooltip" = false;
          };
          "clock" = {
            format = "{:%Y-%m-%d %H:%M:%S}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d %H:%M}";
            "interval" = 1;
            "tooltip" = true;
          };
          "memory" = {
            "interval" = 1;
            "format" = " {percentage}%";
            "states" = {
              "warning" = 85;
            };
          };
          "cpu" = {
            "interval" = 1;
            "format" = " {usage}%";
          };
          "bluetooth" = {
            "format" = " {status}";
            "format-no-controller" = "󰂲";
            "format-disabled" = "󰂲";
            "format-connected" = "";
            "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          };
          "network" = {
            "format-wifi" = "  {signalStrength}% {bandwidthTotalBytes}";
            "format-ethernet" = "{bandwidthTotalBytes}";
            "tooltip-format" = "{ifname} via {gwaddr}";
            "format-linked" = "{ifname} (No IP)";
            "format-disconnected" = " ⚠ ";
            "format-alt" = "{ifname}: {ipaddr}/{cidr} {bandwidthTotalBytes}";
          };
          "battery" = {
            "format" = "{capacity}% {icon}";
            "format-icons" = ["" "" "" "" ""];
          };
          "temperature" = {
            "critical-threshold" = 80;
            "tooltip" = false;
            "format" = " {temperatureC}°C";
          };
          "tray" = {
            "icon-size" = 15;
            "spacing" = 5;
          };
        }
      ];

      style = lib.mkAfter (builtins.readFile ./waybar/style.css);
    };
    stylix.targets.waybar = {
      enable = true;
      addCss = true;
      enableCenterBackColors = false;
      enableLeftBackColors = false;
      enableRightBackColors = false;
    };
  };
}
