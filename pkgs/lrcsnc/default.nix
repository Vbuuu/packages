{
  buildGoModule,
  fetchFromGitHub,
  lib,
  ...
}:
buildGoModule {
  pname = "lrcsnc";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "Endg4meZer0";
    repo = "lrcsnc";
    rev = "f9656e24fdf9cd8abb97c70e9e6eeb3f200e3b9f";
    sha256 = "sha256-aB0au6ab028vo6bmkWC4URiaUZ8MRyDDM9BqejwzFEk=";
  };

  vendorHash = "sha256-ww+SXy29woGlb120sj1oGb4MIQJzpBCKGpUKYsYxTMk=";

  doCheck = false;

  meta = with lib; {
    description = "🎶 Player-agnostic synced lyrics fetcher and displayer ";
    license = licenses.mit;
  };
}
