{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
  openssl,
  cmake,
  pkg-config,
  alsa-lib,
  nasm
}:

stdenv.mkDerivation (final: {
  pname = "mineral";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "10knamesmore";
    repo = "Mineral";
    rev = "v${final.version}";
    hash = "sha256-+Yychxtx5mK9sWHLCMFYA5UyHSTzrKpUYYdLvT0xWkI=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit (final) pname version src;
    hash = "sha256-GtvEGvb59TwXWWADrYbAav6FYGcuKTUKZ3PwSUwsStU=";
  };

  nativeBuildInputs = [
    cargo
    rustc
    cmake
    pkg-config
    rustPlatform.cargoSetupHook
    nasm
  ];

  buildInputs = [
    openssl
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ alsa-lib ];

  dontUseCmakeConfigure = true;

  buildPhase = ''
    runHook preBuild
    cargo build --release --offline
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 target/release/mineral -t $out/bin
    runHook postInstall
  '';
})
