{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.system.cache;
in
{
  options.nixosModules.system.cache = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.system.enable;
    defaultText = lib.literalExpression "config.nixosModules.system.enable";
    description = "Enable binary cache configuration";
  };

  config = lib.mkIf cfg {
    nix.settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
