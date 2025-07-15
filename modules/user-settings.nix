{
  config,
  lib,
  pkgs,
  ...
}: let
  availableDesktops = ["hyprland" "gnome" "kde"];
  availableGreeters = ["gdm" "hyprlock" "regreet" "sddm"];
in {
  options.userSettings = {
    profile = lib.mkOption {
      type = lib.types.enum ["personal" "work"];
      description = "User profile";
    };

    desktopEnv = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableDesktops);
      default = ["hyprland"];
      description = "Desktop environments to use";
    };
    greeter = lib.mkOption {
      type = lib.types.enum availableGreeters;
      default = "gdm";
      description = "Which greeter to use.";
    };

    username = lib.mkOption {
      type = lib.types.str;
      default = "liam";
      description = "Username";
    };
  };
}
