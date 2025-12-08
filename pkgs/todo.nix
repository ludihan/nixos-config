{ inputs, pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "todo";
  version = inputs.todo.lastModifiedDate;

  src = inputs.todo;

  cargoLock = {
    lockFile = "${inputs.todo}/Cargo.lock";
  };
}
