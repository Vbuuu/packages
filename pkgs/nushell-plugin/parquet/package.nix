{
  rustPlatform,
  fetchFromGitHub,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_parquet";
  version = "0.112.2";

  src = fetchFromGitHub {
    owner = "fdncred";
    repo = "nu_plugin_parquet";
    rev = "v0.22.0";
    sha256 = "sha256-TFzYa4jMy664rW+FRKYAcKo+niJg0IcEEyinGrpXbBg=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };

  meta = with lib; {
    mainProgram = "nu_plugin_parquet";
    description = "A nushell plugin to read and write parquet files.";
    license = licenses.mit;
  };
}
