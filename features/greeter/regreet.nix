{
  dendritic.nixos.optional.regreet = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        programs.regreet = {
          enable = true;
          cageArgs = [
            "-s"
            "-mlast"
          ];
        };
        stylix.targets.regreet = {
          enable = true;
          image.enable = true;
        };
      };
    }
  );
}
