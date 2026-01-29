{
  lib,
  config,
  pkgs,
  nix-update-script,
  ...
}: let
  cfg = config.homeModules.apps.nushell;
  userCfg = config.commonModules.system.user;
  nu_plugin_clipboard = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "nu_plugin_clipboard";
    version = "v0.109.0";

    src = pkgs.fetchFromGitHub {
      owner = "FMotalleb";
      repo = "nu_plugin_clipboard";
      tag = finalAttrs.version;
      hash = "sha256-Lh701XvoVaFxa3Cx4/zo0Yr3NLTzZI9GEwipJwkAzDQ=";
    };

    cargoHash = "sha256-dz9sTT1kMt2oAvmdvhrN7j4qwhGg3SbGk4PB4humlBo=";
    buildFeatures = [
      "use-wayland"
    ];

    nativeBuildInputs =
      [
        pkgs.pkg-config
      ]
      ++ lib.optionals pkgs.stdenv.cc.isClang [pkgs.rustPlatform.bindgenHook];
    buildInputs = [pkgs.dbus];

    passthru.updateScript = nix-update-script {};
    meta = {
      description = "Nushell plugin for clipboard interface";
      mainProgram = "nu_plugin_clipboard";
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
    };
  });
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
        plugins = [nu_plugin_clipboard];
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
