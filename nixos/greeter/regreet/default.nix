{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.regreet = {
    enable = true;
    cageArgs = ["-s" "-mlast"];
  };
  stylix.targets.regreet = {
    enable = true;
    useWallpaper = true;
  };
}
