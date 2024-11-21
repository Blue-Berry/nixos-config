{...}: {
  boot.loader.grub.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
}
