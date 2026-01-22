{
  rustPlatform,
  fetchFromGitHub,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_parquet";
  version = "0.108.0";

  src = fetchFromGitHub {
    owner = "fdncred";
    repo = "nu_plugin_parquet";
    rev = "v0.18.0";
    sha256 = "sha256-2DLQzXV9i0zw9O7elixCRvQog2NVMF1ovpsc+OioOrA=";
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
