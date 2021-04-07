{ pkgs }:
let
  project = pkgs.haskellPackages.callPackage ./project.nix { };

in
{
  project = project;
}
