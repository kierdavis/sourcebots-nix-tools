{ name, src, gcc-arm-embedded, python2, stdenv }:

stdenv.mkDerivation {
  inherit name src;
  buildInputs = [ gcc-arm-embedded python2 ];
  preInstall = ''
    export DESTDIR=$out
  '';

  meta = with stdenv.lib; {
    license = licenses.gpl3;
    description = "Open source ARM Cortex-M firmware library";
    homepage = http://libopencm3.org/;
  };
}
