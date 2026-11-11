{inputs, ...}: {
  dendritic.profiles.work.nixos = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        programs.neovim = {
          enable = true;
          defaultEditor = true;
        };
      };
    }
  );
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        programs.neovim = {
          enable = true;
          # Keep legacy provider defaults (stateVersion < 26.05)
          withRuby = true;
          withPython3 = true;
        };

        home.packages = [
          # Use the custom nvim configuration from nixCats flake
          inputs.nixCats.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    }
  );
}
