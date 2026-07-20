{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.nvim;
in
{
  options.homeModules.apps.nvim = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable custom neovim configuration with nixCats";
  };

  config = lib.mkIf cfg {
    programs.neovim = {
      enable = true;
      # Keep legacy provider defaults (stateVersion < 26.05)
      withRuby = true;
      withPython3 = true;
    };

    home.packages = [
      # Use the custom nvim configuration from nixCats flake
      inputs.nixCats.packages.${pkgs.system}.default
    ];
  };
}
