{
  dendritic.nixos.optional.graphics-amd = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        hardware.opengl = {
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = [pkgs.amdvlk];
          extraPackages32 = [pkgs.driversi686Linux.amdvlk];
        };

        boot.initrd.kernelModules = ["amdgpu"];
      };
    }
  );
}
