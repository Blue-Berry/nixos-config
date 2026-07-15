{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.system.gc;
in
{
  options.nixosModules.system.gc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.system.enable;
      defaultText = lib.literalExpression "config.nixosModules.system.enable";
      description = "Enable automatic garbage collection and nix store optimization";
    };

    grubConfigurationLimit = lib.mkOption {
      type = lib.types.int;
      default = 5;
      example = 10;
      description = "Maximum number of boot configurations to keep in GRUB menu";
    };

    dates = lib.mkOption {
      type = lib.types.str;
      default = "weekly";
      example = "daily";
      description = "How often to run garbage collection (systemd timer format)";
    };

    olderThan = lib.mkOption {
      type = lib.types.str;
      default = "3d";
      example = "7d";
      description = "Delete generations older than this (e.g., '3d' = 3 days, '2w' = 2 weeks)";
    };

    optimiseDates = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "daily" ];
      example = [ "weekly" ];
      description = "When to run nix store optimization";
    };

    autoOptimiseStore = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Automatically optimize the nix store after each build";
    };

    minFree = lib.mkOption {
      type = lib.types.int;
      default = 1024 * 1024 * 1024; # 1GB
      example = 5368709120; # 5GB
      description = "Minimum free space in bytes before GC is triggered";
    };

    maxFree = lib.mkOption {
      type = lib.types.int;
      default = 5 * 1024 * 1024 * 1024; # 5GB
      example = 10737418240; # 10GB
      description = "Maximum free space in bytes to maintain after GC";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub.configurationLimit = cfg.grubConfigurationLimit;
    nix.gc = {
      automatic = true;
      dates = cfg.dates;
      options = "--delete-older-than ${cfg.olderThan}";
    };
    nix.optimise = {
      automatic = true;
      dates = cfg.optimiseDates;
    };
    nix.settings.auto-optimise-store = cfg.autoOptimiseStore;
    nix.settings.min-free = cfg.minFree;
    nix.settings.max-free = cfg.maxFree;
  };
}
