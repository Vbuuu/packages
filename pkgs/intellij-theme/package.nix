{
  stdenv,
  jdk17,
}:

stdenv.mkDerivation {
  pname = "intellij-theme";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ jdk17 ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp custom-dark.jar $out/lib/custom-dark.jar

    runHook postInstall
  '';

  meta = {
    description = "JetBrains theme matching my custom dark theme";
  };
}
