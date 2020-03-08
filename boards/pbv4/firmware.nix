{ stdenv, boost, fetchFromGitHub, gcc-arm-embedded, pbv4-libopencm3 }:

stdenv.mkDerivation {
  name = "pbv4-firmware";
  src = fetchFromGitHub {
    owner = "srobo";
    repo = "power-v4-fw";
    fetchSubmodules = true;
    rev = "031d0ed77b803e5aa3dcea7ac5aca3ffe5af3dd7";
    sha256 = "015v171m2gck7jbp2fhdc2rlizpj520cb06i8icg8rawwkrk88j0";
  };
  buildInputs = [ boost gcc-arm-embedded pbv4-libopencm3 ];
  LIBOPENCM3 = "${pbv4-libopencm3}/arm-none-eabi";
  installPhase = ''
    install -D -m 0644 -t $out/images pbv4.{bin,elf} pbv4_noboot.bin pbv4_test.{bin,elf}
    install -D -m 0644 -t $out/oocd oocd/pbv4.cfg

    mkdir -p $out/bin
    cat >$out/bin/pbv4-firmware-dir <<EOF
      #!${stdenv.shell}
      echo $out/images
    EOF
    chmod +x $out/bin/pbv4-firmware-dir
  '';

  meta = with stdenv.lib; {
    #license = XXX;  # FIXME
    description = "Firmware for the PBV4 power board";
    homepage = https://github.com/srobo/power-v4-fw;
  };
}
