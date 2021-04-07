{ mkDerivation, base, mtl, Spock, stdenv, text }:
mkDerivation {
  pname = "spock-playground";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base mtl Spock text ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
