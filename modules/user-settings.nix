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

    syncDevices = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          id = lib.mkOption {
            type = lib.types.str;
            description = "Device ID";
          };
        };
      });
      default = {
        "phone" = {
          id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
        };
      };
      description = "Devices to sync with";
    };

    syncFolders = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          path = lib.mkOption {
            type = lib.types.str;
            description = "Folder path";
          };
          devices = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Devices to sync with";
          };
          ignorePerms = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Ignore file permissions";
          };
        };
      });
      default = {
        "Documents" = {
          path = "~/Documents";
          devices = ["phone"];
          ignorePerms = false;
        };
        "roam" = {
          path = "~/org/roam/";
          devices = ["phone"];
          ignorePerms = false;
        };
      };
      description = "Folders to sync with";
    };

    kanataKbds = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of kbd devices to use for kanata";
    };
  };
}
