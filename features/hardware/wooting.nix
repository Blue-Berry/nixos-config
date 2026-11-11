{
  dendritic.nixos.commonHardware = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        environment.systemPackages = [pkgs.wootility];
        services.udev.packages = [pkgs.wooting-udev];
      };
    }
  );
}
