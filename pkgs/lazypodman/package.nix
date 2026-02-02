{
  buildGoModule,
  fetchFromGitHub,
  lib,
  ...
}:
buildGoModule rec {
  pname = "lazypodman";
  version = "1.0.9";

  src = fetchFromGitHub {
    owner = "lil5";
    repo = "lazypodman";
    tag = "v${version}-podman";
    sha256 = "sha256-QXfmHxM4g8FiWd1QUevPIAO8rW0qi3otsIeRud9VtX4=";
  };

  vendorHash = null;
  
  doCheck = false;

  meta = with lib; {
    description = "The lazier way to manage everything podman";
    license = licenses.mit;
  };
}
