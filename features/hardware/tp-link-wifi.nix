{
  dendritic.nixos.optional.tp-link-wifi = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
      };
    }
  );
}
