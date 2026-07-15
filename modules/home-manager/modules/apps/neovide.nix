{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.neovide;
in
{
  options.homeModules.apps.neovide = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Neovide GUI for Neovim";
  };

  config = lib.mkIf cfg {
    home.packages = [ pkgs.neovide ];
    programs.neovide = {
      enable = true;
      settings = {
        neovim-bin = "n";
      };
    };
  };
}
