{
  dendritic.nixos.commonApps = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        programs.localsend = {
          enable = true;
          openFirewall = true;
        };
      };
    }
  );
}
