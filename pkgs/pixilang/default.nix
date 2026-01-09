{
  stdenv,
  autoPatchelfHook,
  fetchzip,
  lib,
  alsa-lib,
  libglvnd,
  libX11,
  libXi,
  SDL2,
  libGL,
  libxrandr,
  libgcc,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "pixilang";
  version = "3.8.6f";

  src = fetchzip {
    urls = [
      "https://www.warmplace.ru/soft/${finalAttrs.pname}/${finalAttrs.pname}-${finalAttrs.version}.zip"
    ];
    hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    libX11
    libGL
    libxrandr
    libgcc
    alsa-lib
    libglvnd
    libXi
    SDL2
  ];

  installPhase = ''
    runHook preInstall
    runHook postInstall
  '';
})
