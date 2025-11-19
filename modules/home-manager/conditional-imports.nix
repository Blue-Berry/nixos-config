{
  lib,
  userSettings,
  ...
}: let
  desktopModules = {
    hyprland = ../../home-manager/desktop/hyprland/hyprland.nix;
    niri = ../../home-manager/desktop/niri;
    gnome = [];
  };
in {
  imports = let
    inherit (userSettings) desktopEnv;

    selectedDesktops = lib.flatten (map (desktop: desktopModules.${desktop}) desktopEnv);

    # Import waybar once if any Wayland compositor is enabled
    waybarModule =
      if (lib.any (de: de == "hyprland" || de == "niri") desktopEnv)
      then [../../home-manager/desktop/waybar]
      else [];
  in
    selectedDesktops ++ waybarModule;
}
