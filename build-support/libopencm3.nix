{ name, src, gcc-arm-embedded, python2, stdenv }:

stdenv.mkDerivation {
  inherit name src;
  buildInputs = [ gcc-arm-embedded python2 ];
  preInstall = ''
    export DESTDIR=$out
  '';
}
