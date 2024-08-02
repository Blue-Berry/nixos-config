{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.starship
  ];

  programs.starship.enable = true;
  programs.starship.presets = ["nerd-font-symbols"];
}
