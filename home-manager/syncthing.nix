{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:
{
  services.syncthing = {
    enable = true;
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    settings = {
      devices = userSettings.syncDevices;
      folders = userSettings.syncFolders;
    };
  };
}
