{nix-colors, ...}: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  # colorScheme = nix-colors.colorSchemes.kanagawa;
  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
}
