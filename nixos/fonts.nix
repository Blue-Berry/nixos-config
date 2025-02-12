{pkgs, ...}: {
  fonts.packages = with pkgs;
    [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      atkinson-monolegible
      atkinson-hyperlegible
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
