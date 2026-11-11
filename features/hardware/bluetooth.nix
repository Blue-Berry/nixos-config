{
  dendritic.nixos.commonHardware = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        environment.systemPackages = [pkgs.blueman];
        hardware.bluetooth.enable = true;
        services.blueman.enable = true;
      };
    }
  );
}
