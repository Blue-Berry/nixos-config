{ lib, ... }: {
  options.nixosModules.greeter.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all greeter group";
  };

  imports = [
    ./dank-greeter.nix
    ./gdm.nix
    ./greetd-hyprland.nix
    ./regreet.nix
    ./sddm.nix
  ];
}
