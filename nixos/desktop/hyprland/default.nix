{ inputs, pkgs, ... }:
{

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  # stylix = {
  #   enable = true;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  # };
}
