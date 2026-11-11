{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        home.packages = [
          pkgs.cozy
        ];
      };
    }
  );
}
