{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.games.sunshine;
in
{
  options.nixosModules.games.sunshine = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.games.enable;
    defaultText = lib.literalExpression "config.nixosModules.games.enable";
    description = "Enable Sunshine game streaming server";
  };

  config = lib.mkIf cfg {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
