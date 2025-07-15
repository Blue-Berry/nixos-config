{
  lib,
  userSettings,
  ...
}: let
  desktopModules = {
    hyprland = ../../nixos/desktop/hyprland;
    gnome = ../../nixos/desktop/gnome;
    kde = ../../nixos/desktop/kde;
  };

  greeterModules = {
    hyprlock = ../../nixos/greeter/hyprlock;
    gdm = ../../nixos/greeter/gdm;
    sddm = ../../nixos/greeter/sddm;
    regreet = ../../nixos/greeter/regreet;
  };
in {
  imports = let
    inherit (userSettings) desktopEnv greeter;

    selectedDesktops = map (desktop: desktopModules.${desktop}) desktopEnv;
    selectedGreeter = lib.optional (greeterModules ? ${greeter}) greeterModules.${greeter};
  in
    selectedDesktops ++ selectedGreeter;
}
