{
  lib,
  userSettings,
  ...
}: let
  desktopModules = {
    hyprland = ../../home-manager/desktop/hyprland;
    niri =  ../../home-manager/desktop/niri;
  };
in {
  imports = let
    inherit (userSettings) desktopEnv;

    selectedDesktops = map (desktop: desktopModules.${desktop}) desktopEnv;
  in
    selectedDesktops;
}
