{
  dendritic.nixos.optional.gdm = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        services.displayManager.gdm.enable = true;
      };
    }
  );
}
