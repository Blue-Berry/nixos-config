{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.apps.localsend;
in
{
  options.nixosModules.apps.localsend = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable LocalSend with firewall access";
  };

  config = lib.mkIf cfg {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
