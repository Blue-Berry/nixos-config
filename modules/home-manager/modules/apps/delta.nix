{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.delta;
in {
  options.homeModules.apps.delta = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable delta git diff viewer";
  };

  config = lib.mkIf cfg {
    programs.delta.enable = true;
    programs.delta.options = {
      features = "decorations";
      line-numbers = true;
      hyperlinks = true;
    };
  };
}
