{ stdenv, fetchFromGitHub, gcc-arm-embedded, python2 }:

stdenv.mkDerivation {
  name = "libopencm3";
  src = fetchFromGitHub {
    owner = "libopencm3";
    repo = "libopencm3";
    rev = "283d8cc7d2acbfc873897e886658364b12fc5e3b";
    sha256 = "1qbj4bv25bzwqqhi9vscynbn6309lfklahbg7gy1sjqvqmyjjf0y";
  };
  buildInputs = [ gcc-arm-embedded python2 ];
  preInstall = ''
    export DESTDIR=$out
  '';
}
