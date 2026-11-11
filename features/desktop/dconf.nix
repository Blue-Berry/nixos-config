{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };
      };
    }
  );
}
