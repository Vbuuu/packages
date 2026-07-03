{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
  libxcb,
  makeWrapper,
  openssl,
  vulkan-loader,
  wayland,
  lib,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_to_gui";
  version = "0.112.2";

  src = fetchFromGitHub {
    owner = "fdncred";
    repo = "nu_plugin_to_gui";
    rev = "b6d7894d15a175cc0ba9f4f6c87cd59f15586694";
    hash = "sha256-rx1E07fI4xX1Mj+FJ3FRqCsV/RTRg1Na5MmnF4xgT7c=";
  };

  nativeBuildInputs = [
    pkg-config
    libxkbcommon
    libxcb
    makeWrapper
  ];

  buildInputs = [
    openssl
    libxkbcommon
    libxcb
  ];

  postFixup = ''
    wrapProgram $out/bin/nu_plugin_to_gui \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          vulkan-loader
          wayland
        ]
      }
  '';

  cargoLock = {
    lockFile = src + "/Cargo.lock";
    outputHashes = {
      "nu-color-config-0.112.3" = "sha256-5E0vPTpr37nBgDDXyAexHZMyqFNu57DJgOCQKB9pttY=";
    };
  };

  meta = {
    mainProgram = "nu_plugin_to_gui";
    description = "Nushell plugin that uses Zed's GPUI and gpui-components";
  };
}
