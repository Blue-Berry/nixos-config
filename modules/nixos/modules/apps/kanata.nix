{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.apps.kanata;
in {
  options.nixosModules.apps.kanata = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.apps.enable;
      defaultText = lib.literalExpression "config.nixosModules.apps.enable";
      description = "Enable Kanata keyboard remapping service";
    };

    extraDefCfg = lib.mkOption {
      type = lib.types.str;
      default = "process-unmapped-keys yes";
      example = "process-unmapped-keys no";
      description = "Extra configuration options for Kanata defcfg";
    };

    tapTime = lib.mkOption {
      type = lib.types.int;
      default = 200;
      example = 150;
      description = "Tap time threshold in milliseconds for tap-hold keys";
    };

    holdTime = lib.mkOption {
      type = lib.types.int;
      default = 200;
      example = 180;
      description = "Hold time threshold in milliseconds for tap-hold keys";
    };

    config = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = ''
        (defsrc a s d f)
        (deflayer base @a-mod @s-mod @d-mod @f-mod)
      '';
      description = "Custom Kanata configuration. If null, uses default home-row mods config.";
    };
  };

  config = lib.mkIf cfg.enable {
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
          devices = [];
          extraDefCfg = cfg.extraDefCfg;
          config =
            if cfg.config != null
            then cfg.config
            else ''
              (defvar
                tap-time ${toString cfg.tapTime}
                hold-time ${toString cfg.holdTime}
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
  };
}
