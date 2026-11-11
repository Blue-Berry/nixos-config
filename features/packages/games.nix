{
  dendritic.profiles.personal.home = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        home.packages = with pkgs; [
          #KSP
          ckan
          starsector
        ];
      };
    }
  );
}
