{ stdenv, fetchFromGitHub, perl }:

stdenv.mkDerivation {
  name = "pbv4-bake-serial-num";
  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "dfu-bootloader";
    rev = "ce04f2f241ee25d9e7c3348d48f016d7d0cf8d48";
    sha256 = "10j4iii0lzzy76ngjcvx75nvz2yg04ax1n0qpcsclaz9405g1q0g";
  };
  configurePhase = " ";
  buildPhase = ''
    sed s,/usr/bin/perl,${perl}/bin/perl, bake_serial_num.pl > bake_serial_num.nixbuild.pl
  '';
  installPhase = ''
    install -D -m 0755 bake_serial_num.nixbuild.pl $out/bin/pbv4-bake-serial-num
  '';
}
