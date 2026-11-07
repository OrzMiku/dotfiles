{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  cmake,
  pkg-config,
  alsa-lib,
  nasm,
}:
rustPlatform.buildRustPackage (final: {
  pname = "mineral";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "10knamesmore";
    repo = "Mineral";
    rev = "v${final.version}";
    hash = "sha256-+Yychxtx5mK9sWHLCMFYA5UyHSTzrKpUYYdLvT0xWkI=";
  };

  cargoHash = "sha256-GtvEGvb59TwXWWADrYbAav6FYGcuKTUKZ3PwSUwsStU=";

  nativeBuildInputs = [
    cmake
    pkg-config
    nasm
  ];

  buildInputs = [
    openssl
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ alsa-lib ];

  dontUseCmakeConfigure = true;
})
