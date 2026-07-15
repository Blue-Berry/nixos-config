{ outputs, ... }: {
  imports = [
    outputs.commonModules.styling
    outputs.commonModules.system
    ./apps
    ./desktop
    ./packages
    ./env-vars.nix
    ./stylix.nix
    ./syncthing.nix
    ./xdg-mime.nix
  ];
}
