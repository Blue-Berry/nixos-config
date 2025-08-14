{
  lib,
  stdenv,
  gcc,
  janet,
}:
stdenv.mkDerivation {
  pname = "janet-lsp";
  version = "0.0.10";

  src = ./.;

  nativeBuildInputs = [
    gcc
  ];

  buildInputs = [
    janet
  ];

  buildPhase = ''
    gcc -std=c99 -O2 -o janet-lsp janet-lsp.c -ljanet -lm -lpthread -ldl
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp janet-lsp $out/bin/
  '';

  meta = with lib; {
    description = "Language Server Protocol implementation for Janet";
    homepage = "https://github.com/CFiggers/janet-lsp";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}