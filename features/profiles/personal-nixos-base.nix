{
  dendritic.profiles.personal.nixos = {
    imports = [../../profiles/personal/hardware-configuration.nix];
    users.users.liam.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApCooLFWxg2nQbRFImnxOBdp5QfsNc+qZ138utzcD5Z liamandberry@gmail.com"
    ];
  };
}
