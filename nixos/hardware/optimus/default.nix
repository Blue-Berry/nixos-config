{profile, ...}: {
  hardware.nvidia.prime =
    if profile == "work"
    then {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    }
    else {};
}
