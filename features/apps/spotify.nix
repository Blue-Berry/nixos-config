{inputs, ...}: {
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      imports = [
        # For home-manager
        inputs.spicetify-nix.homeManagerModules.default
      ];

      config = {
        programs.spicetify = let
          spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            # adblock
            # hidePodcasts
            shuffle # shuffle+ (special characters are sanitized out of extension names)
            keyboardShortcut
          ];
          # theme = spicePkgs.themes.dribbblish;
          # colorScheme = "catppuccin-macchiato";
          theme = spicePkgs.themes.matte;
          colorScheme = "matte";
        };
      };
    }
  );
}
