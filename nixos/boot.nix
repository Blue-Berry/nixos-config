{pkgs, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = ["uinput"];
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  # boot.kernelPackages = pkgs.linuxPackages_latest;
}
