{
  dendritic.nixos.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        environment.systemPackages = with pkgs; [
          pass
          gnupg
          browserpass
          passff-host
        ];

        programs.browserpass.enable = true;

        programs.firefox.nativeMessagingHosts.packages = [
          pkgs.passff-host
        ];

        programs.gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          pinentryPackage = pkgs.pinentry-qt;
          settings = {
            default-cache-ttl = 604800; # 7 days
            max-cache-ttl = 604800; # 7 days
          };
        };
      };
    }
  );
}
