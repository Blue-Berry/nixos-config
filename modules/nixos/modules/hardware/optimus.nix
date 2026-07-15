{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.hardware.optimus;
in
{
  options.nixosModules.hardware.optimus = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA Optimus support";
    };

    nvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA driver";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      hardware.nvidia.prime = {
        sync.enable = true;
        # offload = {
        #     enable = true;
        #     enableOffloadCmd = true;
        #   };

        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    })

    (lib.mkIf cfg.nvidia {
      hardware.graphics = {
        enable = true;
      };

      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    })
  ];
}
