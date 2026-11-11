{
  dendritic.profiles.personal.nixos = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        environment.systemPackages = [
          pkgs.libratbag
          pkgs.piper
        ];
        services.ratbagd.enable = true;
      };
    }
  );
}
