{inputs, ...}: {
  perSystem = {system, ...}: {
    packages = import ../../pkgs inputs.nixpkgs.legacyPackages.${system};
    formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
  };
}
