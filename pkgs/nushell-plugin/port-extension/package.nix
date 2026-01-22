{
  rustPlatform,
  fetchFromGitHub,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_port_extension";
  version = "0.108.0";

  src = fetchFromGitHub {
    owner = "fmotalleb";
    repo = "nu_plugin_port_extension";
    rev = "v0.108.0";
    sha256 = "sha256-LpbV3SeGUlWtb/Mk9W9NxNLPpOL3Kvaiy+mSF1AYM98=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };

  meta = with lib; {
    mainProgram = "nu_plugin_port_extension";
    description = "A nushell plugin to list all active connections and scanning ports on a target address (replacement of both nu_plugin_port_scan and nu_plugin_port_list since 0.102)";
    license = licenses.mit;
  };
}
