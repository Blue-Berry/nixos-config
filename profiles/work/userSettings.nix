{
  profile = "work";
  desktopEnv = ["hyprland" "gnome"];
  username = "liam";
  greeter = "regreet";
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

  kanataKbds = [
    # Replace the paths below with the appropriate device paths for your setup.
    # Use `ls /dev/input/by-path/` to find your keyboard devices.
    "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
    "/dev/input/by-path/pci-0000:05:00.3-usb-0:2.2.1:1.0-event-kbd"
    "/dev/input/by-path/pci-0000:05:00.3-usbv2-0:2.2.1:1.0-event-kbd"
  ];
}
