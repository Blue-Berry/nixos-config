{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Common System Configuration
  # This file is imported by both nixosModules.nix and homeModules.nix
  commonModules.system.user = {
    username = "liam";
    fullName = "Liam Berry";
    email = "liam.berry@work.com"; # Change to work email
  };

  # Common Styling Configuration
  # This file is imported by both nixosModules.nix and homeModules.nix
  # to ensure consistent theming across NixOS and home-manager
  commonModules.styling.stylix = {
    # Use null to derive colors from wallpaper, or choose a color scheme:
    # "catppuccin-mocha", "tokyo-night-dark", "gruvbox-dark-hard", "nord", "dracula", etc.
    colorScheme = null; # Derive from wallpaper
    # wallpaper = "solar-system-map.jpg";
    # wallpaper = "Soyuz-craft.jpg";
    wallpaper = "black-hole-far.jpg";
    # wallpaper = "pixel-japanese-castle.jpeg";
    polarity = "dark";
    cursorTheme = "Bibata-Modern-Ice";
    cursorSize = 20;
    fontName = "FiraCode Nerd Font Mono";
    fontSize = {
      terminal = 10;
      applications = 11;
      desktop = 10;
      popups = 10;
    };
  };
}
