{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, makeWrapper
, libX11
, libXext
, libXrender
, libXtst
, fontconfig
, freetype
, glib
, gtk3
, qt5
, zlib
, openssl
, libusb1
, udev
, alsa-lib
, nss
, nspr
, postgresql
, unixODBC
}:

stdenv.mkDerivation rec {
  pname = "gowin";
  version = "1.9.11.02_SP1";

  src = fetchurl {
    url = "https://cdn.gowinsemi.com.cn/Gowin_V1.9.11.02_SP1_linux.tar.gz";
    sha256 = "sha256-HtQoU98E/45DRAtnmeaulwdqCZrD0PytQpZ40vpO/08=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    qt5.wrapQtAppsHook
  ];

  buildInputs = [
    libX11
    libXext
    libXrender
    libXtst
    fontconfig
    freetype
    glib
    gtk3
    qt5.qtbase
    qt5.qtx11extras
    qt5.qtvirtualkeyboard
    qt5.qtwebengine
    zlib
    openssl
    libusb1
    udev
    alsa-lib
    nss
    nspr
    postgresql.lib
    unixODBC
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    runHook preUnpack
    tar -xzf $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out
    cp -r IDE/* $out/
    
    # Make binaries executable
    chmod +x $out/bin/gw_ide
    find $out/bin -type f -executable -exec chmod +x {} \;
    
    # Create wrapper for main executable that prioritizes bundled Qt libraries
    makeWrapper $out/bin/gw_ide $out/bin/gowin \
      --prefix LD_LIBRARY_PATH : "$out/lib:${lib.makeLibraryPath buildInputs}" \
      --set QT_XKB_CONFIG_ROOT "${qt5.qtbase.dev}/share/X11/xkb" \
      --set QT_PLUGIN_PATH "$out/plugins/qt" \
      --run 'export GOWIN_DATA_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/gowin"' \
      --run 'mkdir -p "$GOWIN_DATA_DIR"' \
      --run 'cd "$GOWIN_DATA_DIR"' \
      --run 'if [ ! -f gwlicense.ini ]; then ln -sf $out/gwlicense.ini gwlicense.ini 2>/dev/null || true; fi'
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Gowin FPGA development IDE";
    homepage = "https://www.gowinsemi.com/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
