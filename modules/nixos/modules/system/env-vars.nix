{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.system.envVars;
  userCfg = config.commonModules.system.user;
in {
  options.nixosModules.system.envVars = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.system.enable;
      defaultText = lib.literalExpression "config.nixosModules.system.enable";
      description = "Enable environment variable configuration";
    };

    muProfile = lib.mkOption {
      type = lib.types.str;
      default = "personal";
      example = "work";
      description = "Default profile for mu tool";
    };

    extraPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["${userCfg.homeDirectory}/.local/bin"];
      description = "Additional paths to add to PATH";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables = {
      PATH =
        [
          "${userCfg.homeDirectory}/.cargo/bin"
          "${userCfg.homeDirectory}/.cache/rebar3/bin"
          "${userCfg.homeDirectory}/bin"
        ]
        ++ cfg.extraPaths;
      MU_PROFILE = cfg.muProfile;
    };
  };
}
