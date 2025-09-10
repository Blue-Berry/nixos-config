{pkgs, config, ...} : {
  home.sessionVariables = {
    JANET_LIBPATH = "${pkgs.janet}/lib";
    JANET_HEADERPATH ="${pkgs.janet}/include/janet";
    JANET_TREE = "${config.home.homeDirectory}/.local/janet/tree";
    JANET_PATH="${config.home.homeDirectory}/.local/janet/tree/lib";
  };
  home.file.".local/janet/tree/.keep".text = "";

  home.packages = with pkgs; [
    janet
    janet-lsp
    jpm
  ];

}
