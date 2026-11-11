{lib, ...}: {
  dendritic.nixos.base = {
    nix.settings = {
      substituters = lib.mkOrder 900 [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://niri.cachix.org"
        "https://ocaml.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "ocaml.cachix.org-1:8iCoF5mD6PVwNKVfdr4lLs3W7KxfQoYEoPpP+f6f4nM="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
