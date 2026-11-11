{
  dendritic.profiles.work.nixos = {lib, ...}: {
    imports = [../../profiles/work/hardware-configuration.nix];
    users.users.liam = {
      extraGroups = lib.mkOrder 950 ["dialout"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDF4Np5JlKC3AKJ2d+c3XN7i8KI+Yk/29gDBTAUly20T liamandberry@gmail.com"
      ];
    };
    hardware.steam-hardware.enable = true;
  };
}
