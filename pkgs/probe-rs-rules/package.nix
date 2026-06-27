{ stdenvNoCC, fetchurl, ... }:
stdenvNoCC.mkDerivation {
  name = "probe-rs-rules";
  version = "0.0.1";

  src = fetchurl {
    url = "https://probe.rs/files/69-probe-rs.rules";
    hash = "sha256-yjxld5ebm2jpfyzkw+vngBfHu5Nfh2ioLUKQQDY4KYo=";
  };

  dontUnpack = true;

  installPhase = # bash
    ''
      mkdir -p $out/lib/udev/rules.d
      ls
      cp $src $out/lib/udev/rules.d/
    '';
}
