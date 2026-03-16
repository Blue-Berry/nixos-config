{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.apps.gnomeCalendar;
in {
  options.nixosModules.apps.gnomeCalendar = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable GNOME Calendar with online account support";
  };

  config = lib.mkIf cfg {
    programs.dconf.enable = true;
    services.gnome.evolution-data-server.enable = true;
    services.gnome.gnome-online-accounts.enable = true;
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = [
      pkgs.gnome-calendar
    ];
  };
}
