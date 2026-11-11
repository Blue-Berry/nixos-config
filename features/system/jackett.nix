{
  dendritic.profiles.work.nixos = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        services.jackett = {
          package = pkgs.jackett;
          enable = true;
          port = 9117;
        };
      };
    }
  );
}
