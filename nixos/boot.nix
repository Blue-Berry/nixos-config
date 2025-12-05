{pkgs, ...}: {
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = ["uinput"];
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  boot.kernelPackages = pkgs.linuxPackages_6_12; # Pinned for DisplayLink/evdi compatibility (6.18 removed struct_mutex from drm_device)
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    device = "nodev";
    memtest86.enable = true;
  };
}
