{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;
    # portalPackage = pkgs.xdg-desktop-portal-hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  security.polkit.enable = true;
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
