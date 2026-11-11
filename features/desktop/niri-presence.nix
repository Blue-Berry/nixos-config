{lib, ...}: {
  # The upstream Home Manager Niri module does not enable programs.niri when
  # this configuration is installed, so consumers need a composition marker.
  dendritic.home.base.options.homeModules.desktop.niriConfigured = lib.mkOption {
    type = lib.types.bool;
    default = false;
    internal = true;
  };
  dendritic.home.commonApps.homeModules.desktop.niriConfigured = true;
}
