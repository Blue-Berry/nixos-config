{inputs, ...}: {
  dendritic.nixos.commonSystem = (
    {
      lib,
      config,
      ...
    }: {
      # imports = [
      #   inputs.dms.nixosModules.dank-material-shell
      # ];

      config = {
        # Disable niri-flake's polkit agent in favor of DMS's built-in one
        systemd.user.services.niri-flake-polkit.enable = lib.mkIf config.programs.niri.enable false;
      };
    }
  );
  dendritic.home.commonApps = (
    {
      config,
      lib,
      pkgs,
      ...
    }: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
        inputs.dms-plugin-registry.homeModules.default
        inputs.nix-monitor.homeManagerModules.default
      ];

      config = {
        # DMS handles notifications — disable dunst to avoid conflicts
        services.dunst.enable = lib.mkForce false;

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

          settings = lib.mkForce (
            builtins.fromJSON (builtins.readFile ../../modules/home-manager/modules/desktop/dms-settings.json)
          );

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
            if config.homeModules.desktop.niriConfigured
            then {
              enableSpawn = false; # Using systemd service instead
              # Using includes (default) instead of enableKeybinds to avoid conflicts
            }
            else {};

          plugins = {
            # Simply enable plugins by their ID (from the registry)
            dockerManager.enable = true;
            wallpaperCarousel.enable = true;
            nixMonitor.enable = true;

            # Add plugin-specific settings
            mediaPlayer = {
              enable = true;

              # You can only define settings here if using the home-manager module
              settings = {
                preferredSource = "spotify";
              };
            };
          };
        };

        programs.nix-monitor = {
          enable = true;
          rebuildCommand = [
            "bash"
            "-c"
            "sudo nixos-rebuild switch --flake ~/nixos-config#work && home-manager switch --flake ~/nixos-config#work 2>&1"
          ];
        };
      };
    }
  );
}
