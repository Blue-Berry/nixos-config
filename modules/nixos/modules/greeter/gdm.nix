{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.greeter.gdm;
in {
  options.nixosModules.greeter.gdm = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.greeter.enable;
    defaultText = lib.literalExpression "config.nixosModules.greeter.enable";
    description = "Enable GNOME Display Manager";
  };

  config = lib.mkIf cfg {
    services.displayManager.gdm.enable = true;
  };
}
