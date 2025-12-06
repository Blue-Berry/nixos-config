{
  lib,
  config,
  pkgs,
  ...
}: {
  options.nixosModules.boot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable boot configuration with GRUB";
    };

    kernelPackages = lib.mkOption {
      type = lib.types.raw;
      default = pkgs.linuxPackages_zen;
      description = "What kernel packages and kernel version to use";
    };
  };

  config = lib.mkIf config.nixosModules.boot.enable {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelModules = ["uinput"];
    boot.binfmt.emulatedSystems = ["aarch64-linux"];

    boot.kernelPackages = config.nixosModules.boot.kernelPackages;

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
      memtest86.enable = true;
    };
  };
}
