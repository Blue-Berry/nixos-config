{
  config,
  inputs,
  ...
}: let
  optional = config.dendritic.nixos.optional;
  evaluate = module:
    (inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [module];
    }).config;
in {
  perSystem = {
    system,
    pkgs,
    ...
  }:
    if system == "x86_64-linux"
    then {
      checks.optional-modules = assert (evaluate optional.starship).programs.starship.enable;
      assert (evaluate optional.hyprlock).programs.hyprlock.enable;
      assert (evaluate optional.touchpad).services.libinput.enable;
        pkgs.runCommand "optional-modules" {} "touch $out";
    }
    else {};
}
