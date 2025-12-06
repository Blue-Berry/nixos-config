{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.apps.starship;
in {
  options.nixosModules.apps.starship = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable Starship shell prompt";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [
      pkgs.starship
    ];

    programs.starship = {
      enable = true;
      presets = ["nerd-font-symbols"];
    };
  };
}
