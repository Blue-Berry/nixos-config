{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.homeModules.packages.llm;
in {
  options.homeModules.packages.llm.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.packages.programming;
    defaultText = lib.literalExpression "config.homeModules.packages.llm.enable";
    description = "Enable LLM tools and packages";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [inputs.claude-code.overlays.default];
    home.packages = with pkgs; [
      claude-code
      codex
    ];
  };
}
