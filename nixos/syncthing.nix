{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    syncthing = {
      enable = true;
      group = "liamDocs";
      user = "liam";
      dataDir = "/home/liam/Documents/";
      configDir = "/home/liam/Documents/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "phone" = {
            id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
          };
        };
        folders = {
          "Documents" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/home/myusername/Documents"; # Which folder to add to Syncthing
            devices = [
              "phone"
            ]; # Which devices to share the folder with
          };
          "roam" = {
            path = "/home/liam/org/roam/";
            devices = [ "phone" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
        };
      };
    };
  };
}
