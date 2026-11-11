{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: let
      cfg = config.homeModules.desktop.kanshi;
    in {
      options.homeModules.desktop.kanshi = {
        settings = lib.mkOption {
          type = lib.types.listOf lib.types.attrs;
          default = [];
          example = lib.literalExpression ''
            [
              { include = "path/to/included/files"; }
              { output.criteria = "eDP-1";
                output.scale = 2;
              }
              { profile.name = "undocked";
                profile.outputs = [
                  { criteria = "eDP-1"; }
                ];
              }
              { profile.name = "docked";
                profile.outputs = [
                  { criteria = "eDP-1"; }
                  { criteria = "Some Company ASDF 4242";
                    transform = "90";
                  }
                ];
              }
            ]
          '';
          description = ''
            Ordered list of kanshi directives.
            Each directive can be either:
            - A profile directive with profile.name and profile.outputs
            - An output directive with output.criteria and other output properties
            - An include directive with an include path
            See kanshi(5) for more information.
          '';
        };
      };

      config = {
        services.kanshi = {
          enable = true;
          settings = cfg.settings;
        };
      };
    }
  );
}
