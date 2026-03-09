{
  lib,
  config,
  pkgs,
  nix-update-script,
  ...
}: let
  cfg = config.homeModules.apps.nushell;
  userCfg = config.commonModules.system.user;
in {
  options.homeModules.apps.nushell = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Nushell shell";
  };

  config = lib.mkIf cfg {
    programs = {
      nushell = {
        enable = true;
        # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
        configFile.source = ./nushell/config.nu;
        # for editing directly to config.nu
        extraConfig = ''
          let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
          }
          $env.config = {
           show_banner: true,
           completions: {
           case_sensitive: false # case-sensitive completions
           quick: true    # set to false to prevent auto-selecting completions
           partial: true    # set to false to prevent partial filling of the prompt
           algorithm: "fuzzy"    # prefix or fuzzy
           external: {
           # set to false to prevent nushell looking into $env.PATH to find more suggestions
               enable: true
           # set to lower can improve completion performance at the cost of omitting some options
               max_results: 100
               completer: $carapace_completer # check 'carapace_completer'
             }
           }
          }
          $env.PATH = ($env.PATH |
          split row (char esep) |
          prepend ${userCfg.homeDirectory}/.apps |
          append /usr/bin/env
          )
        '';
        shellAliases = {
          vim = "n";
        };
      };
      carapace.enable = true;
      carapace.enableNushellIntegration = true;
    };
    stylix.targets.nushell.enable = true;
  };
}
