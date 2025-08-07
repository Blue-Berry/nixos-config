{
  profile = "work";
  desktopEnv = ["hyprland" "gnome"];
  username = "liam";
  greeter = "gdm";
  syncDevices = {
    "phone" = {
      id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
    };
    "personal" = {
      id = "EAQAYXJ-XQMSQRB-F4FCS5Q-W7AC2LO-S7EBTFK-EHWSU5O-LAN5RBC-5CXP5AC";
    };
  };

  syncFolders = {
    "Documents" = {
      path = "~/Documents";
      devices = ["phone" "personal"];
      ignorePerms = false;
    };
    "roam" = {
      path = "~/org/roam/";
      devices = ["phone" "personal"];
      ignorePerms = false;
    };
  };
}
