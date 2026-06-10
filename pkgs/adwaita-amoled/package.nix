{
  stdenvNoCC,
  fetchFromGitHub,
  glib,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "Adwaita-AMOLED";

  src = fetchFromGitHub {
    owner = "librerob";
    repo = "adwaita-amoled";
    rev = "2b3680a8b973a533e351086c9430df08eaa3738d";
    hash = "sha256-mwqbtlpyJe3Z0Vo69SWLu6R4Tk07/R0VUad8xVgxb0A=";
  };

  patches = [ ./customize.patch ];

  nativeBuildInputs = [
    glib
  ];

  configurePhase = ''
    patchShebangs ./build.sh
  '';

  buildPhase = ''
    ./build.sh
  '';

  installPhase = ''
    mkdir -p $out/share/themes/Adwaita-AMOLED
    cp -r ./gtk-2.0 ./gtk-3.0 ./gtk-4.0 ./index.theme "$out/share/themes/Adwaita-AMOLED"
  '';
}
