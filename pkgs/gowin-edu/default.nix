{ lib
, stdenv
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
, pkgs
, speechd
}:

stdenv.mkDerivation rec {
  pname = "gowin-edu";
  version = "1.9.11.01";

  src = pkgs.fetchurl {
    url = "https://cdn.gowinsemi.com.cn/Gowin_V1.9.11.01_Education_Linux.tar.gz";
    sha256 = "03md5ywwjx1214b3xvv0v1bkii0ca6dq0wynw2xy9anc755r6vi3";
    curlOptsList = [
      "--user-agent" "Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0"
      "--header" "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
      "--header" "Accept-Language: en-US,en;q=0.5"
      "--header" "Accept-Encoding: gzip, deflate, br, zstd"
      "--header" "Sec-GPC: 1"
      "--header" "Connection: keep-alive"
      "--header" "Upgrade-Insecure-Requests: 1"
      "--header" "Sec-Fetch-Dest: document"
      "--header" "Sec-Fetch-Mode: navigate"
      "--header" "Sec-Fetch-Site: cross-site"
      "--header" "Priority: u=0, i"
      "--header" "Pragma: no-cache"
      "--header" "Cache-Control: no-cache"
      "--header" "TE: trailers"
      "--connect-timeout" "60"
      "--max-time" "3600"
      "--retry" "3"
      "--retry-delay" "5"
      "--progress-bar"
      "--verbose"
    ];
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    qt5.wrapQtAppsHook
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libQt5SerialBus.so.5"
    "libQt5WebView.so.5"
    "libQt5Designer.so.5"
    "libQt5Quick3DAssetImport.so.5"
    "libQt5Quick3DRender.so.5"
    "libQt5Quick3DUtils.so.5"
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
    qt5.qt3d
    qt5.qtgamepad
    qt5.qtsensors
    qt5.qtserialport
    qt5.qtspeech
    speechd
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
    
    mkdir -p $out/gowin-edu
    cp -r IDE/* $out/gowin-edu/
    
    # Make binaries executable
    chmod +x $out/gowin-edu/bin/gw_ide
    find $out/gowin-edu/bin -type f -executable -exec chmod +x {} \;
    
    # Create wrapper in main bin directory
    mkdir -p $out/bin
    makeWrapper $out/gowin-edu/bin/gw_ide $out/bin/gowin-edu \
      --prefix LD_LIBRARY_PATH : "$out/gowin-edu/lib:${lib.makeLibraryPath buildInputs}" \
      --set QT_XKB_CONFIG_ROOT "${qt5.qtbase.dev}/share/X11/xkb" \
      --set QT_PLUGIN_PATH "$out/gowin-edu/plugins/qt"
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Gowin FPGA development IDE (Educational version)";
    homepage = "https://www.gowinsemi.com/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
