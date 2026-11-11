{config, ...}: {
  dendritic.profiles.personal.nixos.imports = [config.dendritic.nixos.commonHardware];
  dendritic.profiles.work.nixos.imports = [config.dendritic.nixos.commonHardware];
}
