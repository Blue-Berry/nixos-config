{pkgs, ...}: {
  environment.systemPackages = [pkgs.libratbag pkgs.piper];
    services.ratbagd.enable = true;
}
