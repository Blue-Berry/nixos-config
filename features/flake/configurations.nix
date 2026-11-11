{
  config,
  inputs,
  ...
}: let
  inherit (inputs) self nixpkgs home-manager;
  outputs = self;
  mkSystem = name:
    nixpkgs.lib.nixosSystem {
      modules = [
        config.dendritic.profiles.${name}.common
        config.dendritic.profiles.${name}.nixos
        config.dendritic.nixos.base
      ];
    };
  mkHome = name:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = builtins.attrValues outputs.overlays;
        config.allowUnfree = true;
      };
      modules = [
        config.dendritic.profiles.${name}.common
        config.dendritic.profiles.${name}.home
        config.dendritic.home.base
      ];
    };
in {
  flake = {
    overlays = import ../../overlays {inherit inputs;};
    nixosModules = import ../../modules/nixos;
    commonModules = import ../../modules/common;
    homeModules = import ../../modules/home-manager;
    nixosConfigurations = {
      personal = mkSystem "personal";
      work = mkSystem "work";
    };
    homeConfigurations = {
      personal = mkHome "personal";
      work = mkHome "work";
    };
  };
}
