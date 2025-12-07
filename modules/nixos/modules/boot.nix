{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.boot;
in {
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

    dualBoot = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable dual boot with GRUB";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelModules = ["uinput"];
    boot.binfmt.emulatedSystems = ["aarch64-linux"];

    boot.kernelPackages = cfg.kernelPackages;

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      useOSProber = cfg.dualBoot;
      device = "nodev";
      memtest86.enable = true;
    };
  };
}
