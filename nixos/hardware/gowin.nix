{
  config,
  lib,
  pkgs,
  ...
}: {
  services.udev.packages = [pkgs.gowin-udev];
}
