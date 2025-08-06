{
  profile = "personal";
  desktopEnv = ["hyprland" "gnome"];
  username = "liam";
  greeter = "hyprlock";
  
  syncDevices = {
    "phone" = {
      id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
    };
  };
  
  syncFolders = {
    "Documents" = {
      path = "~/Documents";
      devices = ["phone"];
      ignorePerms = false;
    };
    "roam" = {
      path = "~/org/roam/";
      devices = ["phone"];
      ignorePerms = false;
    };
  };
}
