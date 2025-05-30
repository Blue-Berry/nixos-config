_: {
  boot.loader.grub.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
}
