{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.apps.cachix-agent;
in
{
  options.nixosModules.apps.cachix-agent = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Cachix Agent for uploading build artifacts to Cachix";
  };

  config = lib.mkIf cfg {
    services.cachix-agent.enable = true;
  };
}
