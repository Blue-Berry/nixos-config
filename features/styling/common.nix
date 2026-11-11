{inputs, ...}: let
  shared = {
    config,
    lib,
    pkgs,
    ...
  } @ args:
    import ../../modules/common/styling/stylix-common.nix (args // {inherit inputs;});
in {
  dendritic.nixos.base.imports = [shared];
  dendritic.home.base.imports = [shared];
}
