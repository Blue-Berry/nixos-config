{
  lib,
  config,
  ...
}:
let
  cfg = config.nixosModules.hardware.ntfs;
in
{
  options.nixosModules.hardware.ntfs = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable NTFS filesystem support";
  };

  config = lib.mkIf cfg {
    boot.supportedFilesystems = [ "ntfs" ];
  };
}
