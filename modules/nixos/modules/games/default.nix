{lib, ...}: {
  options.nixosModules.games.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all games group";
  };

  imports = [
    ./sunshine.nix
  ];
}
