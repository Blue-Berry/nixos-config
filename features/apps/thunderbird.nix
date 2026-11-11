{
  dendritic.profiles.work.home = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        # programs.thunderbird.enable = true;

        home.packages = [pkgs.thunderbird-latest-unwrapped];
      };
    }
  );
}
