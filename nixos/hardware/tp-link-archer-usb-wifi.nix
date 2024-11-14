{config, ...}: {
  boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
}
