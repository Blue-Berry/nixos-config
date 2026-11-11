{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        home.packages = [pkgs.kitty];
        programs.kitty = {
          enable = true;
          themeFile = "Catppuccin-Mocha";
          # font = {
          #   # name = "FiraCode Nerd Font Mono";
          #   name = lib.mkForce "Hasklug Nerd Font Mono";
          #   size = 10;
          # };
          settings = {
            # background_opacity = "0.8";
            background_blur = 1;
            dynamic_background_opacity = true;
            enable_audio_bell = false;
          };
        };
      };
    }
  );
}
