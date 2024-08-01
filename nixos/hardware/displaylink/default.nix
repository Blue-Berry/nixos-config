{...}:
{
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
#nix-prefetch-url --name displaylink-580.zip https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip
}
