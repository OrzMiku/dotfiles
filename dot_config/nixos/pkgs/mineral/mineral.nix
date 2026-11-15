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
  sqlite,
}:
rustPlatform.buildRustPackage (final: {
  pname = "mineral";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "10knamesmore";
    repo = "Mineral";
    rev = "v${final.version}";
    hash = "sha256-4LGCNvc127gQbmre8AGVkVCXQ2MxcTfmSnWLDvoKDF4=";
  };

  cargoHash = "sha256-Xfns1BiHzTWDXua47wmAsvbTgWdVDpOq+f+yT0IsZV0=";

  nativeBuildInputs = [
    cmake
    pkg-config
    nasm
  ];

  buildInputs = [
    openssl
    sqlite
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ alsa-lib ];

  dontUseCmakeConfigure = true;
})
