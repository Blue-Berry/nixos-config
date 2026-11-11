{
  dendritic.nixos.optional.hyprlock = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        programs.hyprlock.enable = true;
      };
    }
  );
}
