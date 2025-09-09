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

  kanataKbds = [
    # Replace the paths below with the appropriate device paths for your setup.
    # Use `ls /dev/input/by-path/` to find your keyboard devices.
    # "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
    # "/dev/input/by-path/pci-0000:00:14.0-usb-0:1:1.1-event-kbd"
    # "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:1:1.1-event-kbd"
  ];
}
