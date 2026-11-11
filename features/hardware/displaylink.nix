{
  dendritic.profiles.work.nixos = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        services.xserver.videoDrivers = [
          "displaylink"
          "modesetting"
        ];
        environment.systemPackages = with pkgs; [
          displaylink
        ];
      };
    }
  );
}
