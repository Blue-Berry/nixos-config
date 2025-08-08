{
  lib,
  stdenv,
  janet,
}:

stdenv.mkDerivation rec {
  pname = "mu";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ janet ];
  buildInputs = [ janet ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    
    # Simply copy the working mu script and fix the shebang
    cp mu $out/bin/mu
    
    # Replace nix-shell shebang with direct janet shebang
    sed -i '1,2c\#!/usr/bin/env janet' $out/bin/mu
    
    # Make executable
    chmod +x $out/bin/mu
    
    # Install the lib directory alongside the binary for relative imports
    mkdir -p $out/bin
    cp -r lib $out/bin/
    
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