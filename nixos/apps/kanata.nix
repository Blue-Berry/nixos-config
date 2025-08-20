{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  boot.kernelModules = ["uinput"];
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = {};

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        # devices = [
        #   # Replace the paths below with the appropriate device paths for your setup.
        #   # Use `ls /dev/input/by-path/` to find your keyboard devices.
        #   "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        #   "/dev/input/by-path/pci-0000:05:00.3-usb-0:2.2.1:1.0-event-kbd"
        #   "/dev/input/by-path/pci-0000:05:00.3-usbv2-0:2.2.1:1.0-event-kbd"
        # ];
        devices = userSettings.kanataKbds;
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defvar
            tap-time 200
            hold-time 200
          )

          (defsrc
            a s d f   j k l ;
          )

          (defalias
            a-mod (tap-hold $tap-time $hold-time a lmet)
            s-mod (tap-hold $tap-time $hold-time s lalt)
            d-mod (tap-hold $tap-time $hold-time d lsft)
            f-mod (tap-hold $tap-time $hold-time f lctl)
            j-mod (tap-hold $tap-time $hold-time j rctl)
            k-mod (tap-hold $tap-time $hold-time k rsft)
            l-mod (tap-hold $tap-time $hold-time l ralt)
            ;-mod (tap-hold $tap-time $hold-time ; rmet)
          )

          (deflayer base
            @a-mod @s-mod @d-mod @f-mod   @j-mod @k-mod @l-mod @;-mod
          )
        '';
      };
    };
  };
}
