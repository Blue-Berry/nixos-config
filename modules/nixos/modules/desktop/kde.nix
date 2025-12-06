{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.desktop.kde;
in {
  options.nixosModules.desktop.kde = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.desktop.enable;
    defaultText = lib.literalExpression "config.nixosModules.desktop.enable";
    description = "Enable KDE Plasma desktop environment";
  };

  config = lib.mkIf cfg {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    programs.kdeconnect.enable = true;
  };
}
