{
  dendritic.nixos.commonHardware = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        environment.systemPackages = [
          pkgs.sigrok-firmware-fx2lafw
          pkgs.pulseview
          pkgs.sigrok-cli
        ];
      };
    }
  );
}
