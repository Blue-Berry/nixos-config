{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        home.packages = [pkgs.neovide];
        programs.neovide = {
          enable = true;
          settings = {
            neovim-bin = "n";
          };
        };
      };
    }
  );
}
