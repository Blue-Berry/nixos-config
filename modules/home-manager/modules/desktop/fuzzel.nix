{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings.main.font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=14";
  };
  stylix.targets.fuzzel = {
    colors.enable = true;
    enable = true;
    fonts.enable = true;
    icons.enable = true;
    opacity = {
      enable = true;
      override = {
        popups = 0.70;
      };
    };
    polarity.enable = true;
  };
}
