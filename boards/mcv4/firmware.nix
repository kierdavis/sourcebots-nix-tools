{ stdenv, fetchFromGitHub, gcc-arm-embedded, mcv4-libopencm3 }:

stdenv.mkDerivation {
  name = "mcv4-firmware";
  src = fetchFromGitHub {
    owner = "srobo";
    repo = "motor-v4-fw";
    fetchSubmodules = true;
    rev = "6d21289a9bc43aa76d1ecd573993e604e7cb0814";
    sha256 = "1cd9ikawbn4wrdrxyslg8lg7kmmg2zmsbgx2h2nz95wbcafcv1yf";
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
