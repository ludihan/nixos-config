{
  rustPlatform,
  fetchFromGitHub,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "todo";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "ludihan";
    repo = "todo";
    rev = "v${version}";
    hash = "sha256-+7u7snbRA1TRXRQuIyZtMyasRTtXp9X66SIAfnpCdxY=";
  };

  cargoHash = "sha256-UavcdE7cGxtCq8vnY5O78Dvo8LzNFocAJr1OJFUGFFQ=";
}
