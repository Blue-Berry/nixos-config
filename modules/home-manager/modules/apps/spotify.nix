{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.homeModules.apps.spotify;
in
{
  options.homeModules.apps.spotify = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Spotify with Spicetify";
  };

  imports = [
    # For home-manager
    inputs.spicetify-nix.homeManagerModules.default
  ];

  config = lib.mkIf cfg {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
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
