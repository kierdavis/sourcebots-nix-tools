{ stdenv, fetchFromGitHub, gcc-arm-embedded, mcv4-libopencm3 }:

stdenv.mkDerivation {
  name = "mcv4-firmware";
  src = fetchFromGitHub {
    owner = "srobo";
    repo = "motor-v4-fw";
    fetchSubmodules = true;
    rev = "292f135e097aef31a755a225de4b3814d9e3c474";
    sha256 = "1f0izkaii721alb0srpbd9jph2zd5xsz42y0kbyyyk6ngfdlgl9c";
  };
  buildInputs = [ gcc-arm-embedded mcv4-libopencm3 ];
  TOOLCHAIN_DIR = "${mcv4-libopencm3}/arm-none-eabi";
  installPhase = ''
    install -D -m 0644 -t $out/images mcv4.{bin,elf} mcv4_test.{bin,elf}
    install -D -m 0644 -t $out/oocd oocd/mcv4.cfg

    mkdir -p $out/bin
    cat >$out/bin/mcv4-firmware-dir <<EOF
      #!${stdenv.shell}
      echo $out/images
    EOF
    chmod +x $out/bin/mcv4-firmware-dir
  '';

  meta = with stdenv.lib; {
    #license = XXX;  # FIXME
    description = "Firmware for the MCV4 motor controller board";
    homepage = https://github.com/srobo/motor-v4-fw;
  };
}
