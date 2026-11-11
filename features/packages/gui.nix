{inputs, ...}: {
  dendritic.home.commonPackages = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      config = {
        programs.zen-browser = {
          enable = true;
          nativeMessagingHosts = [
            pkgs.browserpass
            pkgs.passff-host
          ];
        };
        home.packages = with pkgs; [
          # Browsers
          chromium
          firefox

          # Communication
          discord
          teams-for-linux

          # Media
          calibre
          easyeffects
          mpv
          vlc

          # Development
          # vscode
          obsidian

          # Utilities
          btop-rocm
          dotool
          glow
          gparted
          hydrapaper
          inetutils
          libreoffice
          # newsflash # slow build
          qbittorrent
          showcolors
          steam-run
          wineWow64Packages.stable
          winetricks
          wl-clipboard-x11

          # Fonts
          font-awesome

          # Gaming
          prismlauncher

          # Other
          base16-schemes
          # inputs.gowin-eda.packages.${pkgs.system}.gowin-eda
          ntfs3g
          okolors
        ];
      };
    }
  );
}
