{
  lib,
  config,
  ...
}: let
  cfg = config.homeModules.desktop.dconf;
in {
  options.homeModules.desktop.dconf = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.desktop.enable;
    defaultText = lib.literalExpression "config.homeModules.desktop.enable";
    description = "Enable dconf GNOME settings";
  };

  config = lib.mkIf cfg {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
