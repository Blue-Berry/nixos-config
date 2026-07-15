{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.greeter.sddm;
in
{
  options.nixosModules.greeter.sddm = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.greeter.enable;
    defaultText = lib.literalExpression "config.nixosModules.greeter.enable";
    description = "Enable Simple Desktop Display Manager";
  };

  config = lib.mkIf cfg {
    services.displayManager.sddm.enable = true;
  };
}
