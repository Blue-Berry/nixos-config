{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.styling.fonts;
in
{
  options.nixosModules.styling.fonts = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.styling.enable;
    defaultText = lib.literalExpression "config.nixosModules.styling.enable";
    description = "Enable font packages";
  };

  config = lib.mkIf cfg {
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      atkinson-monolegible
      atkinson-hyperlegible
    ];
  };
}
