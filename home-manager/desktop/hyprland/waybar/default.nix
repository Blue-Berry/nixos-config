{pkgs, ...}: {
  home.packages = with pkgs; [
    mpc-cli
    waybar
    pamixer
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
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          # "backlight"
          "memory"
          "cpu"
          "bluetooth"
          "network"
          "tray"
          "clock"
          "battery"
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
        # "backlight" = {
        #   "device" = "intel_backlight";
        #   "on-scroll-up" = "light -A 5";
        #   "on-scroll-down" = "light -U 5";
        #   "format" = "{icon} {percent}%";
        #   "format-icons" = ["󰃝" "󰃞" "󰃟" "󰃠"];
        # };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon}   {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = ["" "" ""];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
          "interval" = 1;
          "tooltip" = true;
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰍛 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰻠 {usage}%";
        };
        "bluetooth" = {
          # "controller"= "controller1", // specify the alias of the controller if there are more than 1 on the system
          "format" = " {status}";
          "format-disabled" = "";
          "format-connected" = "";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        };
        "network" = {
          "format-wifi" = "  {signalStrength}%";
          "format-ethernet" = "{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = " ⚠ ";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "battery" = {
          "format" = "{capacity}% {icon}";
          "format-icons" = ["" "" "" "" ""];
        };
        "temperature" = {
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];

    style = ./style.css;
  };
}
