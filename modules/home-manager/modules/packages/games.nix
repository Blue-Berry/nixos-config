{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.packages.games;
in {
  options.homeModules.packages.games = lib.mkOption {
    type = lib.types.bool;
    default = false;
    defaultText = lib.literalExpression "config.homeModules.games.enable";
    description = "Enable eextra game packages";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      #KSP
      ckan
    ];
  };
}
