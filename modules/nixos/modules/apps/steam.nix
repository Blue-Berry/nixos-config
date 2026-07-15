{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.apps.steam;
in
{
  options.nixosModules.apps.steam = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable Steam gaming platform with GameMode";
  };

  config = lib.mkIf cfg {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          defaultgov = "performance";
          desiredgov = "performance";
          renice = 10;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
}
