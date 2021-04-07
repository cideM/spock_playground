let
  sources = import ./nix/sources.nix;

  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          Spock = pkgs.haskell.lib.dontCheck haskellPackagesOld.Spock;
        };
      };
    };
  };

  pkgs = import sources.nixpkgs { inherit config; };

  projectEnv = (import ./release.nix { pkgs = pkgs; }).project.env;

in
pkgs.mkShell {
  inputsFrom = [ projectEnv ];
  buildInputs = with pkgs.haskellPackages;
    [
      # Haskell
      ghcid
      ormolu
      hlint
      cabal2nix
      haskell-language-server
      cabal-install
      cabal-fmt
      fast-tags
      hoogle
    ];
}
