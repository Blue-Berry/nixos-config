{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        programs.delta.enable = true;
        programs.delta.options = {
          features = "decorations";
          line-numbers = true;
          hyperlinks = true;
        };
      };
    }
  );
}
