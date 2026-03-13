{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.homeModules.desktop.dsm;
in {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];
  options.homeModules.desktop.dsm = lib.mkOption {
    type = lib.types.bool;
    default = !config.homeModules.desktop.waybar;
    defaultText = lib.literalExpression "config.homeModules.desktop.enable";
    description = "Enable DankMaterialShell";
  };

  config = lib.mkIf cfg {
    programs.dank-material-shell = {
      enable = true;

      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
      };

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

      settings = {
        theme = "dark";
        dynamicTheming = true;
        # Add any other settings here
      };

      clipboardSettings = {
        maxHistory = 25;
        maxEntrySize = 5242880;
        autoClearDays = 1;
        clearAtStartup = true;
        disabled = false;
        disableHistory = false;
        disablePersist = true;
      };
      # Niri integrations
      niri =
        if config.homeModules.desktop.niri
        then {
          enableKeybinds = true; # Sets static preset keybinds
          enableSpawn = true; # Auto-start DMS with niri, if enabled
        }
        else {};
    };
  };
}
