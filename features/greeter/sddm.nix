{
  dendritic.nixos.optional.sddm = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        services.displayManager.sddm.enable = true;
      };
    }
  );
}
