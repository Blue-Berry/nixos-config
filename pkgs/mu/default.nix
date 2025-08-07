{
  lib,
  stdenv,
  janet,
}:

stdenv.mkDerivation rec {
  pname = "mu";
  version = "0.1.0";

  src = ./.;

  buildInputs = [ janet ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp mu $out/bin/
    chmod +x $out/bin/mu
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "NixOS Configuration Manager - Simple system management tool";
    homepage = "https://github.com/yourusername/nixos-config";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}