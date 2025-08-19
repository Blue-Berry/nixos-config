{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./cli.nix
    ./programming.nix
  ];
  home.packages = with pkgs; [
    base16-schemes
    btop-rocm
    bubblewrap # For opam
    calibre
    chromium
    claude-code
    discord
    dotool
    easyeffects
    firefox
    font-awesome
    git
    glow
    hydrapaper
    inetutils
    inputs.nixCats.packages."${pkgs.system}".default
    inputs.zen-browser.packages."${pkgs.system}".specific
    kitty
    libqalculate
    libreoffice-fresh
    mpv
    neovide
    newsflash
    ntfs3g
    obsidian
    okolors
    prismlauncher
    qalculate-qt
    qbittorrent
    showcolors
    steam-run
    teams-for-linux
    vlc
    vscode
    wineWowPackages.stable
    winetricks
    wireshark
    xclip
    zed-editor
    # gowin-ide
  ];
}
