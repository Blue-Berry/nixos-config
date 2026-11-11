{
  dendritic.nixos.commonSystem = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        nix.settings = {
          substituters = lib.mkOrder 1100 [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
          ];

          trusted-public-keys = lib.mkOrder 1100 [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
        };
      };
    }
  );
}
