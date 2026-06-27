{
  rustPlatform,
  fetchFromGitHub,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_port_extension";
  version = "0.112.2";

  src = fetchFromGitHub {
    owner = "fmotalleb";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Q5oaRuZ3fFtIoyY+HPGujm/bqU+udjK5lb4HfMlFrnA=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };

  meta = with lib; {
    mainProgram = pname;
    description = "A nushell plugin to list all active connections and scanning ports on a target address (replacement of both nu_plugin_port_scan and nu_plugin_port_list since 0.102)";
    license = licenses.mit;
  };
}
