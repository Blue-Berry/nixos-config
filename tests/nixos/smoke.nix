{
  pkgs,
  commonSystem,
}:
pkgs.testers.runNixOSTest {
  name = "shared-user-ssh";
  nodes.machine = {config, ...}: {
    imports = [commonSystem];
    commonModules.system.user.username = "liam";
    users.users.${config.commonModules.system.user.username} = {
      isNormalUser = true;
      home = config.commonModules.system.user.homeDirectory;
    };
    services.openssh.enable = true;
  };
  testScript = ''
    machine.wait_for_unit("sshd.service")
    machine.succeed("id liam")
    machine.succeed("getent passwd liam | grep /home/liam")
  '';
}
