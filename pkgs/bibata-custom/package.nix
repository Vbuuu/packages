{
  stdenvNoCC,
  fetchFromGitHub,
  clickgen,
  cbmp,
  backgroundColor ? "#050707",
  outlineColor ? "#E5E5D0",
  ...
}:
stdenvNoCC.mkDerivation {
  name = "bibata-custom";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "ful1e5";
    repo = "Bibata_Cursor";
    rev = "v2.0.7";
    hash = "sha256-kIKidw1vditpuxO1gVuZeUPdWBzkiksO/q2R/+DUdEc=";
  };

  nativeBuildInputs = [
    clickgen
    (cbmp.overrideAttrs (old: {
      patches = old.patches or [ ] ++ [
        ./cbmp-disable-ora.patch
      ];
    }))
  ];

  buildPhase = ''
    cbmp -d 'svg/modern' -o 'bitmaps/Bibata-Custom' -bc '${backgroundColor}' -oc '${outlineColor}'

    ctgen configs/normal/x.build.toml -p x11 -d 'bitmaps/Bibata-Custom' -n 'Bibata-Custom' -c 'Custom Cursor'
  '';

  installPhase = ''
    install -dm 0755 $out/share/icons
    cp -rf themes/* $out/share/icons/
  '';
}
