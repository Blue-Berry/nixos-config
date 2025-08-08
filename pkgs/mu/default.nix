{
  lib,
  stdenv,
  janet,
  nixos-rebuild,
  home-manager,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "mu";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ janet makeWrapper ];
  buildInputs = [ janet ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin $out/lib/mu
    
    # Install the lib directory  
    cp -r lib $out/lib/mu/
    
    # Create the core Janet script
    cp mu $out/lib/mu/mu-core
    sed -i '1,2c\#!/usr/bin/env janet' $out/lib/mu/mu-core
    chmod +x $out/lib/mu/mu-core
    
    # Create wrapper script with proper PATH (use system sudo, not Nix store sudo)
    makeWrapper $out/lib/mu/mu-core $out/bin/mu \
      --prefix PATH : ${lib.makeBinPath [ nixos-rebuild home-manager ]} \
      --prefix PATH : /run/wrappers/bin
    
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