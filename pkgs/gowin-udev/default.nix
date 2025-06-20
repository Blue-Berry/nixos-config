{
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "gowin-udev-rules";
  version = "0.0.1";

  src = [./50-programmer_usb.rules];

  dontUnpack = true;

  installPhase = ''
    install -Dpm644 $src $out/lib/udev/rules.d/50-programmer_usb.rules
  '';

  meta = with lib; {
    homepage = "";
    description = "udev rules that give NixOS permission to communicate with Gowin FPGA";
    platforms = platforms.linux;
    license = "unknown";
    maintainers = with maintainers; [LiamBerry];
  };
}
