{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.system.jackett;
in {
  options.nixosModules.system.jackett = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.system.enable;
    defaultText = lib.literalExpression "config.nixosModules.system.enable";
    description = "Enable essential system packages";
  };

  config = lib.mkIf cfg {
    services.jackett = {
      package = pkgs.jackett;
      enable = true;
      port = 9117;
    };
  };
}
