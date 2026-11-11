{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      nix-update-script,
      ...
    }: let
      userCfg = config.commonModules.system.user;
    in {
      config = {
        programs = {
          nushell = {
            enable = true;
            # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
            configFile.source = ../../modules/home-manager/modules/apps/nushell/config.nu;
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
  );
}
