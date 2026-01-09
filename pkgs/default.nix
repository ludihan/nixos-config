{ inputs, pkgs }:
let
  importPackages =
    names:
    builtins.listToAttrs (
      map (name: {
        name = name;
        value = import (./. + "/${name}") pkgs;
      }) names
    );
in
importPackages [
  "todo"
  "pixilang"
  # "bookokrat"
]
