{
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  name = "adwaita-amoled-qt";

  src = fetchFromGitHub {
    owner = "librerob";
    repo = "adwaita-amoled";
    rev = "2b3680a8b973a533e351086c9430df08eaa3738d";
    hash = "sha256-mwqbtlpyJe3Z0Vo69SWLu6R4Tk07/R0VUad8xVgxb0A=";
  };

  # Recolours the upstream qt5ct/qt6ct scheme + scrollbar stylesheet to the
  # AMOLED palette (same colours as the gtk theme's customize.patch).
  patches = [ ./qt-extra.patch ];

  # extra/qt5ct and extra/qt6ct ship identical files
  installPhase = ''
    install -Dm444 extra/qt5ct/colors/Adwaita-AMOLED.conf $out/share/color-schemes/Adwaita-AMOLED.conf
    install -Dm444 extra/qt5ct/qss/fusion-simple-scrollbar.qss $out/share/qss/fusion-simple-scrollbar.qss
  '';
}
