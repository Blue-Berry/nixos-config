{
  lib,
  userSettings,
  ...
}: let
  desktopModules = {
    hyprland = ../../home-manager/desktop/hyprland/hyprland.nix;
    niri =  ../../home-manager/desktop/niri;
    gnome = [];
  };
in {
  imports = let
    inherit (userSettings) desktopEnv;

    selectedDesktops = lib.flatten (map (desktop: desktopModules.${desktop}) desktopEnv);
  in
    selectedDesktops;
}
