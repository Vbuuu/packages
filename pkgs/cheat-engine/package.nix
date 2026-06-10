{
  stdenv,
  lib,
  fetchurl,
  unzip,
  autoPatchelfHook,
  makeWrapper,
  qt6,
  zlib,
  libGL,
  libx11,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "cheat-engine";
  version = "7.7";

  src = fetchurl {
    url = "https://cheatengine.org/download/CheatEngineLinux77.zip";
    sha256 = "sha256-Lv/pYIAVVnNyzMle0FZWT/7tfYKQI45jeBFbLiEd164=";
  };

  sourceRoot = "CheatEngineLinux77";

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    qt6.qtbase
    libx11
    zlib
    stdenv.cc.cc.lib
  ];

  dontBuild = true;
  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/cheat-engine $out/bin
    cp -r . $out/opt/cheat-engine
    chmod +x $out/opt/cheat-engine/{cheatengine,tutorial,gtutorial}-x86_64

    makeWrapper $out/opt/cheat-engine/cheatengine-x86_64 $out/bin/cheat-engine \
      --chdir $out/opt/cheat-engine \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL ]}
    for bin in tutorial gtutorial; do
      makeWrapper $out/opt/cheat-engine/$bin-x86_64 $out/bin/cheat-engine-$bin \
        --chdir $out/opt/cheat-engine \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL ]}
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Memory scanner and debugger for Linux";
    homepage = "https://cheatengine.org";
    license = licenses.unfree;
    mainProgram = "cheat-engine";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
})
