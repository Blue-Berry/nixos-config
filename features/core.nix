{lib, ...}: {
  options.dendritic.nixos.base = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Shared NixOS contributions assembled by feature modules.";
  };
  options.dendritic.nixos.optional = lib.mkOption {
    type = lib.types.attrsOf lib.types.deferredModule;
    default = {};
    description = "Selectable NixOS modules that are not part of every profile.";
  };
  options.dendritic.nixos.commonHardware = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Hardware features shared by the personal and work profiles.";
  };
  options.dendritic.nixos.commonApps = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Applications shared by the personal and work NixOS profiles.";
  };
  options.dendritic.nixos.commonSystem = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "System services shared by the personal and work profiles.";
  };
  options.dendritic.home.base = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Shared standalone Home Manager contributions assembled by feature modules.";
  };
  options.dendritic.home.commonApps = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Applications shared by the personal and work home profiles.";
  };
  options.dendritic.home.optional = lib.mkOption {
    type = lib.types.attrsOf lib.types.deferredModule;
    default = {};
    description = "Selectable Home Manager modules that are not part of every profile.";
  };
  options.dendritic.home.commonPackages = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Package collections shared by the personal and work profiles.";
  };
  options.dendritic.profiles = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          nixos = lib.mkOption {
            type = lib.types.deferredModule;
            default = {};
          };
          home = lib.mkOption {
            type = lib.types.deferredModule;
            default = {};
          };
          common = lib.mkOption {
            type = lib.types.deferredModule;
            default = {};
          };
          identity = lib.mkOption {
            type = lib.types.submodule {
              options = {
                username = lib.mkOption {
                  type = lib.types.str;
                  default = "liam";
                };
                fullName = lib.mkOption {
                  type = lib.types.str;
                  default = "Liam Berry";
                };
                email = lib.mkOption {type = lib.types.str;};
              };
            };
          };
          theme = lib.mkOption {
            type = lib.types.submodule {
              options = {
                colorScheme = lib.mkOption {
                  type = lib.types.str;
                  default = "catppuccin-mocha";
                };
                wallpaper = lib.mkOption {
                  type = lib.types.str;
                  default = "pixel-japanese-castle.jpeg";
                };
                polarity = lib.mkOption {
                  type = lib.types.str;
                  default = "dark";
                };
                cursorTheme = lib.mkOption {
                  type = lib.types.str;
                  default = "Bibata-Modern-Ice";
                };
                cursorSize = lib.mkOption {
                  type = lib.types.int;
                  default = 20;
                };
                fontName = lib.mkOption {
                  type = lib.types.str;
                  default = "FiraCode Nerd Font Mono";
                };
                fontSize = lib.mkOption {
                  type = lib.types.attrsOf lib.types.int;
                  default = {
                    terminal = 10;
                    applications = 11;
                    desktop = 10;
                    popups = 10;
                  };
                };
              };
            };
            default = {};
          };
        };
      }
    );
    default = {};
    description = "Profile-specific NixOS and standalone Home Manager contributions.";
  };
}
