{
  dendritic.nixos.optional.gnome-calendar = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        programs.dconf.enable = true;
        services.gnome.evolution-data-server.enable = true;
        services.gnome.gnome-online-accounts.enable = true;
        services.gnome.gnome-keyring.enable = true;

        environment.systemPackages = [
          pkgs.gnome-calendar
        ];
      };
    }
  );
}
