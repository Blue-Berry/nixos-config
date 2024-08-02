{...}: {
  # Set neovim as default editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
