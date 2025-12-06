{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.apps.zsh;
in {
  options.nixosModules.apps.zsh = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable Zsh shell as default";
  };

  config = lib.mkIf cfg {
    environment.shells = with pkgs; [zsh];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;
  };
}
