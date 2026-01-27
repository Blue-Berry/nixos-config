{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.opencode;
in {
  options.homeModules.apps.opencode = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable OpenCode VSCode launcher";
  };

  config = lib.mkIf cfg {
    programs.opencode = {
      enable = true;
      package = inputs.opencode-nix.packages.${pkgs.system}.default;
      settings = {
        autoshare = false;
        autoupdate = true;
        lsp = {
          ocamllsp = {
            command = ["ocamllsp"];
            extensions = [
              ".ml"
              ".mli"
            ];
          };
          nil = {
            command = ["nil"];
            extensions = [".nix"];
          };
          nixd = {
            command = ["nixd"];
            extensions = [".nix"];
          };
        };
        mcp = {
          ocaml-mcp-server = {
            type = "local";
            command = ["ocaml-mcp-server"];
            enabled = true;
          };
        };
        formatter = {
          ocamlformat = {
            command = ["ocamlformat"];
            extensions = [
              ".ml"
              ".mli"
            ];
          };
        };
      };
    };
    stylix.targets.opencode.enable = true;
  };
}
