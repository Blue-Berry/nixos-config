{...}: {
  imports = [
    ./stylix-common.nix
    ./stylix-ls-colors.nix
  ];

  stylix = {
    ls-colors.enable = true;
    targets = {
      grub = {
        enable = true;
        useWallpaper = true;
      };
      gnome.enable = true;
      gtk.enable = true;
      qt.enable = true;
    };
  };
}
