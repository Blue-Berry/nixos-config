{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.apps.platformio;
in {
  options.nixosModules.apps.platformio = lib.mkOption {
    type = lib.types.bool;
    default = false;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable Platformio";
  };

  config = lib.mkIf cfg {
    services.udev.packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];
  };
}
