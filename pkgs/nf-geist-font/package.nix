{
  stdenvNoCC,
  geist-font,
  nerd-font-patcher,
  parallel,
  lib,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "nerd-geist-font";
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
      -name \*.otf ! -name '*Mono*' -print0 | \
      ${lib.getExe parallel} -j ''${NIX_BUILD_CORES:0} -u -0 \
      ${lib.getExe nerd-font-patcher} --complete --quiet --no-progressbars {}

    find ${geist-font}/share/fonts/opentype \
      -name \*.otf -name '*Mono*' -print0 | \
      ${lib.getExe parallel} -j ''${NIX_BUILD_CORES:0} -u -0 \
      ${lib.getExe nerd-font-patcher} --complete --use-single-width-glyphs --adjust-line-height --quiet --no-progressbars {}
  '';
}
