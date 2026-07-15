{
  lib,
  config,
  ...
}:
{
  options.nixosModules.apps.nvim = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable neovim as default editor";
  };

  config = lib.mkIf config.nixosModules.apps.nvim {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
