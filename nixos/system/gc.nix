_: {
  boot.loader.grub.configurationLimit = 5;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
  nix.optimise = {
    automatic = true;
    dates = ["daily"];
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.min-free = 1024 * 1024 * 1024; # 1GB
  nix.settings.max-free = 5 * 1024 * 1024 * 1024; # 5GB
}
