{...}: {
  imports = [
    ./stylix-common.nix
    ./stylix-ls-colors.nix
  ];

  stylix.ls-colors.enable = true;
}
