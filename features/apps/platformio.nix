{
  dendritic.profiles.work.nixos = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        services.udev.packages = [
          pkgs.platformio-core
          pkgs.openocd
        ];
      };
    }
  );
}
