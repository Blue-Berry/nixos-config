{inputs, ...}: {
  dendritic.nixos.base = {
    imports = [
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
      inputs.self.commonModules.system
    ];
  };
  dendritic.home.base = {
    imports = [
      inputs.stylix.homeModules.stylix
      inputs.niri-config.homeModules.niri
      inputs.niri-config.homeModules.stylix
      inputs.self.commonModules.system
    ];
  };
}
