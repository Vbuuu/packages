{
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_nupsql";
  version = "0.108.0";

  src = fetchFromGitLab {
    owner = "HertelP";
    repo = "nu_plugin_nupsql";
    rev = "9ecd2b82633fdbfc76b531623de6780e2d63665a";
    sha256 = "sha256-VVikWS5SZJpu8Sb3kAWQ9tjU7xIVc30FrKuaB9jv8mM=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    mainProgram = "nu_plugin_nupsql";
    description = "A nushell plugin to query postgres databases.";
    license = licenses.mit;
  };
}
