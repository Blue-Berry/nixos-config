{config, ...}: {
  dendritic.profiles.personal.home.imports = [config.dendritic.home.commonApps];
  dendritic.profiles.work.home.imports = [config.dendritic.home.commonApps];
}
