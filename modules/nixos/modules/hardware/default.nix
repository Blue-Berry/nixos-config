{ lib, ... }: {
  options.nixosModules.hardware.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all hardware group";
  };

  imports = [
    ./acpid.nix
    ./bluetooth.nix
    ./ddcutil.nix
    ./displaylink.nix
    ./gowin.nix
    ./graphics-amd.nix
    ./logic-analyzer.nix
    ./ntfs.nix
    ./optimus.nix
    ./ratbag.nix
    ./solaar.nix
    ./sound.nix
    ./touchpad.nix
    ./tp-link-wifi.nix
    ./wooting.nix
  ];
}
