{ lib, ... }: {
  options.nixosModules.system.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all system group";
  };

  imports = [
    ./cache.nix
    ./containers.nix
    ./env-vars.nix
    ./flatpak.nix
    ./gc.nix
    ./packages.nix
    ./ports.nix
    ./vm.nix
    ./jackett.nix
  ];
}
