{
  dendritic.profiles.work.nixos = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        services.acpid.enable = true;
      };
    }
  );
}
