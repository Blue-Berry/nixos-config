{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.regreet.enable = true;
  stylix.targets.regreet = {
    enable = true;
    useWallpaper = true;
  };
}
