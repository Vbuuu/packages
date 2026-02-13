{
  fetchurl,
  buildFHSEnv,
  lib,
  makeDesktopItem,
  symlinkJoin,
  ...
}:
let
  version = "2.7.2";
  pname = "enigma";

  jar = fetchurl {
    url = "https://maven.quiltmc.org/repository/release/org/quiltmc/enigma-swing/${version}/enigma-swing-${version}-all.jar";
    hash = "sha256-MSzLZURLMOfw4nVMObrwKciZ4NGA25Xz14M3REOlTTE=";
  };

  enigma = buildFHSEnv {
    inherit pname version;

    targetPkgs =
      p: with p; [
        jar

        openjdk25
        cairo
        gdk-pixbuf
        glib
        gtk3
      ];

    runScript = "java -jar ${jar}";

    meta = with lib; {
      description = "A deobfuscation/remapping tool for Java bytecode, fork of cuchaz's Enigma.";
      homepage = "https://github.com/QuiltMC/enigma";
      license = licenses.lgpl3;
      mainProgram = pname;
      sourceProvenance = [ sourceTypes.binaryBytecode ];
    };
  };

  desktop = makeDesktopItem rec {
    name = "Enigma";
    desktopName = name;
    exec = "${enigma}/bin/${pname}";
    terminal = false;
  };
in
symlinkJoin {
  name = pname;
  paths = [
    enigma
    desktop
  ];
}
