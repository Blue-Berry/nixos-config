{
  profile = "personal";
  desktopEnv = ["hyprland" "gnome"];
  username = "liam";
  greeter = "hyprlock";

  syncDevices = {
    "phone" = {
      id = "7FACKTB-VRXUUBY-62KQYCB-XUSHLG2-7UGUEDP-O2DXFOF-LCG67E5-TCFNOAO";
    };
    "work" = {
      id = "R6KDI5U-O4CUY7L-IATHVCY-MIDKOJR-MSLFJVT-VE6HTMN-JDALETZ-AX4SRQC";
    };
  };

  syncFolders = {
    "Documents" = {
      path = "~/Documents";
      devices = ["phone" "work"];
      ignorePerms = false;
    };
    "roam" = {
      path = "~/org/roam/";
      devices = ["phone" "work"];
      ignorePerms = false;
    };
  };
}
