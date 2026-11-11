{
  dendritic.nixos.commonHardware = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        services.udev.packages = [pkgs.gowin-udev];
      };
    }
  );
}
