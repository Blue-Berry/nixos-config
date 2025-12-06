{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.hardware.sound;
in {
  options.nixosModules.hardware.sound = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable sound with PipeWire";
  };

  config = lib.mkIf cfg {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
