{config, ...}: {
  dendritic.nixos.optional.optimus = {
    hardware.nvidia.prime = {
      sync.enable = true;
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  dendritic.nixos.optional.nvidia = {config, ...}: {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };
  dendritic.profiles.work.nixos.imports = [
    config.dendritic.nixos.optional.optimus
    config.dendritic.nixos.optional.nvidia
  ];
}
