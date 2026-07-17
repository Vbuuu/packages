{
  lib,
  rustPlatform,
  fetchFromGitHub,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  wayland,
  libxkbcommon,
  vulkan-loader,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "viewskater";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "ggand0";
    repo = "viewskater";
    rev = version;
    hash = "sha256-sb7V9C+9jtxox6scK7lp6/SJgTQ6hJ2WJqofq2KYE4c=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
    outputHashes = {
      "dpi-0.1.1" = "sha256-hPFiNxKX2AoHs2EX2B8Rdh+B3YO0kA4iXGa2fY91648=";
      "iced-0.13.5" = "sha256-KTGFk7mQaO74CQb3Kl7BBqphVnsjDOkEbM6u1d1p5Fo=";
      "iced_aw-0.11.0" = "sha256-oI776slfuECNIzZ+Mb5faIPjpKSG7nYd3oIjwjBzn5I=";
    };
  };

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "viewskater";
      exec = "viewskater %f";
      desktopName = "Viewskater";
      categories = [
        "Graphics"
        "Viewer"
      ];
      startupWMClass = "viewskater";
      mimeTypes = [
        "image/png"
        "image/jpeg"
        "image/webp"
        "image/tiff"
        "image/bmp"
      ];
    })
  ];

  postFixup = ''
    wrapProgram $out/bin/viewskater \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          wayland
          libxkbcommon
          vulkan-loader
        ]
      }
  '';

  meta = {
    mainProgram = "viewskater";
    description = "A fast image viewer for browsing large collections of images. ";
  };
}
