{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        programs.vivid = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
        stylix.targets.vivid.enable = true;
      };
    }
  );
}
