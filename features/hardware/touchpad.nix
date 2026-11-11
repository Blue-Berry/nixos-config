{
  dendritic.nixos.optional.touchpad = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        services.libinput.enable = true;
      };
    }
  );
}
