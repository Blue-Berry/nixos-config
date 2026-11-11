{
  dendritic.nixos.commonHardware = (
    {
      lib,
      config,
      ...
    }: {
      config = {
        boot.supportedFilesystems = ["ntfs"];
      };
    }
  );
}
