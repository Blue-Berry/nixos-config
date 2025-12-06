{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.desktop.gnome;
in {
  options.nixosModules.desktop.gnome = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.desktop.enable;
    defaultText = lib.literalExpression "config.nixosModules.desktop.enable";
    description = "Enable GNOME desktop environment";
  };

  config = lib.mkIf cfg {
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = [pkgs.orca];
    environment.systemPackages = [
      pkgs.gnomeExtensions.blur-my-shell
    ];
    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };
}
