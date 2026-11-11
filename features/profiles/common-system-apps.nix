{config, ...}: {
  dendritic.profiles.personal.nixos.imports = [config.dendritic.nixos.commonApps];
  dendritic.profiles.work.nixos.imports = [config.dendritic.nixos.commonApps];
}
