{
  config,
  lib,
  ...
}: {
  config = lib.mkMerge [
    {
      dendritic.profiles = lib.genAttrs ["personal" "work"] (name: {
        common = {
          commonModules.system.user = {
            inherit (config.dendritic.profiles.${name}.identity) username fullName email;
          };
          commonModules.styling.stylix = {
            inherit
              (config.dendritic.profiles.${name}.theme)
              colorScheme
              wallpaper
              polarity
              cursorTheme
              cursorSize
              fontName
              fontSize
              ;
          };
        };
      });
    }
    {
      dendritic.profiles.personal.identity.email = "Liamandberry@gmail.com";
      dendritic.profiles.work.identity.email = "liam.berry@work.com";
    }
  ];
}
