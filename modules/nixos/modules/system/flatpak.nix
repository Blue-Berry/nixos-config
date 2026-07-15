{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.system.flatpak;
in
{
  options.nixosModules.system.flatpak = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.system.enable;
    defaultText = lib.literalExpression "config.nixosModules.system.enable";
    description = "Enable Flatpak package manager";
  };

  config = lib.mkIf cfg {
    services.flatpak.enable = true;
  };
}
