{
  dendritic.nixos.commonApps = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        services.cachix-agent.enable = true;
      };
    }
  );
}
