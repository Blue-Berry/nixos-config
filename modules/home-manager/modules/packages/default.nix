{lib, ...}: {
  options.homeModules.packages.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all packages group";
  };

  imports = [
    ./cli.nix
    ./gui.nix
    ./janet.nix
    ./programming.nix
    ./llm.nix
  ];
}
