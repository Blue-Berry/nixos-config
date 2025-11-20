{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  environment.systemPackages = [pkgs.ddcutil];
  boot.kernelModules = ["i2c-dev"];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  users.users.${userSettings.username}.extraGroups = ["i2c"];
}
