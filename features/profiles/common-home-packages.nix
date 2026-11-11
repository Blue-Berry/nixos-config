{config, ...}: {
  dendritic.profiles.personal.home.imports = [config.dendritic.home.commonPackages];
  dendritic.profiles.work.home.imports = [config.dendritic.home.commonPackages];
}
