{
  rustPlatform,
  fetchFromGitHub,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "bookokrat";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "bugzmanov";
    repo = "bookokrat";
    rev = "v${version}";
    hash = "sha256-if2HcH0P9B+Cx6yLazOnmzKxaTTSR+Ohy0dcmlNICMw=";
  };

  cargoLock.lockFile = ./Cargo.lock;
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';
  doCheck = false;

  cargoHash = "sha256-UavcdE7cGxtCq8vnY5O78Dvo8LzNFocAJr1OJFUGFFQ=";
}
