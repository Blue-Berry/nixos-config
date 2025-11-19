{
  lib,
  stdenv,
  bash,
  substituteAll,
}:
stdenv.mkDerivation {
  pname = "gowin-udev-rules";
  version = "0.0.1";

  src = ./50-programmer_usb.rules;

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    substitute $src $out/lib/udev/rules.d/50-programmer_usb.rules \
      --replace-fail "/bin/sh" "${bash}/bin/sh" \
      --replace-fail "/bin/bash" "${bash}/bin/bash"
  '';

  meta = with lib; {
    homepage = "";
    description = "udev rules that give NixOS permission to communicate with Gowin FPGA";
    platforms = platforms.linux;
    license = "unknown";
    maintainers = with maintainers; [LiamBerry];
  };
}
