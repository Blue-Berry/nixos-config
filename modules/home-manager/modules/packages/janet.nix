{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.packages.janet;
in {
  options.homeModules.packages.janet = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.packages.programming;
    defaultText = lib.literalExpression "config.homeModules.packages.programming";
    description = "Enable Janet language tools";
  };

  config = lib.mkIf cfg {
    home.sessionVariables = {
      JANET_LIBPATH = "${pkgs.janet}/lib";
      JANET_HEADERPATH = "${pkgs.janet}/include/janet";
      JANET_TREE = "${config.home.homeDirectory}/.local/janet/tree";
      JANET_PATH = "${config.home.homeDirectory}/.local/janet/tree/lib";
    };
    home.file.".local/janet/tree/.keep".text = "";

    home.packages = with pkgs; [
      janet
      janet-lsp
      jpm
    ];
  };
}
