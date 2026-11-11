{config, ...}: {
  dendritic.profiles.personal.nixos.imports = [config.dendritic.nixos.commonSystem];
  dendritic.profiles.work.nixos.imports = [config.dendritic.nixos.commonSystem];
}
