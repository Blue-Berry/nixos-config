{ outputs, ... }: {
  imports = [
    outputs.commonModules.styling
    outputs.commonModules.system
    ./boot.nix
    ./apps
    ./desktop
    ./games
    ./greeter
    ./hardware
    ./styling
    ./system
  ];
}
