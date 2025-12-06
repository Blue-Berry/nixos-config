{lib, ...}: {
  options.nixosModules.styling.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all styling group";
  };

  imports = [
    ./fonts.nix
    ./ls-colors.nix
    ./stylix.nix
  ];
}
