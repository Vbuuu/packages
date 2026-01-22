{
  stdenvNoCC,
  geist-font,
  nerd-font-patcher,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "NF-Geist-Font";
  version = (builtins.parseDrvName geist-font.name).version;

  nativeNuildInputs = [
    nerd-font-patcher
  ];

  phases = [ "installPhase" ];

  preInstall = ''
    mkdir -p $out/share/fonts/opentype && cd "$_"
  '';

  installPhase = ''
    runHook preInstall

    find ${geist-font}/share/fonts/opentype \
      -name \*.otf \
      -exec ${nerd-font-patcher}/bin/nerd-font-patcher --complete --quiet --no-progressbars {} \; \
      -exec ${nerd-font-patcher}/bin/nerd-font-patcher --complete --use-single-width-glyphs --adjust-line-height --quiet --no-progressbars {} \;
  '';
}
