{inputs, ...}: {
  dendritic.nixos.commonSystem = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        # NixOS-specific stylix targets only
        # Base config (image, polarity, cursor, fonts) comes from common module

        stylix = {
          # ls-colors.enable = true;
          targets = {
            grub = {
              enable = true;
              useWallpaper = true;
            };
            console.enable = true;
            gnome.enable = true;
            gtk.enable = true;
            qt.enable = true;
          };
        };
      };
    }
  );
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        # home-manager-specific stylix configuration
        # Base config comes from common module

        # Explicitly enable cursor config generation (stylix sets package/name/size)
        home.pointerCursor.enable = true;

        stylix = {
          opacity = {
            terminal = 0.8;
          };
          targets = {
            zen-browser = {
              profileNames = ["Main"];
              enable = false;
            };
            hyprland.hyprpaper.enable = true;
            hyprpaper.enable = true;
            hyprlock = {
              enable = true;
              image.enable = true;
            };
            yazi.enable = true;
            bat.enable = true;
            btop.enable = true;
            hyprland.enable = true;
            spicetify.enable = false;
            ghostty.enable = true;
            fzf.enable = true;
            dunst.enable = !config.programs.dank-material-shell.enable;
            firefox = {
              enable = true;
              colorTheme.enable = true;
            };
            gtk = {
              enable = true;
            };
            xresources.enable = true;
            qt.enable = true;
            starship.enable = true;
            gnome = {
              image.enable = true;
              enable = true;
            };
            lazygit.enable = true;
          };
        };
      };
    }
  );
}
