{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: let
      cfg = config.homeModules.syncthing;
    in {
      options.homeModules.syncthing = {
        devices = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          example = lib.literalExpression ''
            {
              "phone" = {
                id = "DEVICE-ID-HERE";
              };
              "work" = {
                id = "DEVICE-ID-HERE";
              };
            }
          '';
          description = "Syncthing devices configuration";
        };

        folders = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          example = lib.literalExpression ''
            {
              "Documents" = {
                path = "~/Documents";
                devices = [ "phone" "work" ];
                ignorePerms = false;
              };
            }
          '';
          description = "Syncthing folders configuration";
        };
      };

      config = {
        services.syncthing = {
          enable = true;
          overrideDevices = true;
          overrideFolders = true;
          settings = {
            devices = cfg.devices;
            folders = cfg.folders;
          };
        };
      };
    }
  );
}
