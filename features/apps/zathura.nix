{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        programs.zathura = {
          enable = true;
        };
        stylix.targets.zathura = {
          enable = true;
          colors.enable = true;
          opacity.enable = true;
        };
      };
    }
  );
}
