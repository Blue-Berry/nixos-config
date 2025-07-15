{pkgs, ...}: {
  imports = [
    ../nixos/stylix-common.nix
  ];
  stylix = {
    opacity = {
      terminal = 0.8;
    };
    targets = {
      hyprland.hyprpaper.enable = true;
      hyprpaper.enable = true;
      hyprlock = {
        enable = true;
        useWallpaper = true;
      };
      yazi.enable = true;
      bat.enable = true;
      btop.enable = true;
      hyprland.enable = true;
      spicetify.enable = false;
      ghostty.enable = true;
      fzf.enable = true;
      dunst.enable = true;
      firefox = {
        enable = true;
        colorTheme.enable = true;
      };
      gtk = {
        enable = true;
      };
      qt.enable = true;
      starship.enable = true;
      zathura.enable = true;
      gnome = {
        useWallpaper = true;
        enable = true;
      };
      lazygit.enable = true;
    };
  };
}
