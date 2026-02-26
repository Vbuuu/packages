{
  buildGoModule,
  fetchFromGitHub,
  lib,
  ...
}:
buildGoModule rec {
  pname = "lrcsnc";
  version = "0.1.3-1";

  src = fetchFromGitHub {
    owner = "Endg4meZer0";
    repo = "lrcsnc";
    tag = "v${version}";
    sha256 = "sha256-/lDOWxPl9Z6LellbbuGMNMhiqQfulKmogQ/KnlGus3g=";
  };

  vendorHash = "sha256-33BiLjmMcPAyd0SEGA24MnaW74L764bcU1A6s1pl3+8=";

  doCheck = false;

  meta = with lib; {
    description = "🎶 Player-agnostic synced lyrics fetcher and displayer";
    license = licenses.mit;
  };
}
