{
  fetchurl,
  buildFHSEnv,
  lib,
  makeDesktopItem,
  symlinkJoin,
  ...
}:

let
  version = "0.8.8";
  pname = "recaf-launcher";

  jar = fetchurl {
    url = "https://github.com/Col-E/Recaf-Launcher/releases/download/${version}/recaf-gui-${version}.jar";
    hash = "sha256-fa220O6fH1dUlgGkoAGMYuFPOA6NIdSDn5tdoeSxDbg=";
  };

  # Basis-derivation: das bestehende buildFHSEnv-Paket, wie zuvor
  recaf = buildFHSEnv {
    inherit pname version;

    targetPkgs =
      p: with p; [
        jar

        openjdk25
        libx11
        at-spi2-atk
        cairo
        gdk-pixbuf
        glib
        gtk3
        pango
        libxtst
        xorg_sys_opengl
      ];

    runScript = "java -jar ${jar}";

    meta = with lib; {
      description = "Simple launcher for Recaf 4.X and above - a modern Java bytecode editor";
      homepage = "https://recaf.coley.software";
      changelog = "https://github.com/Col-E/Recaf-Launcher/releases/tag/${version}/CHANGELOG.md";
      license = licenses.mit;
      mainProgram = pname;
      sourceProvenance = [ sourceTypes.binaryBytecode ];
    };
  };

  desktop = makeDesktopItem rec {
    name = "Recaf Launcher";
    desktopName = name;
    exec = "${recaf}/bin/${pname}";
    terminal = false;
  };

in
symlinkJoin {
  name = pname;
  paths = [
    recaf
    desktop
  ];
}
