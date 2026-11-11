{
  dendritic.nixos.commonSystem = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        services.flatpak.enable = true;
      };
    }
  );
}
