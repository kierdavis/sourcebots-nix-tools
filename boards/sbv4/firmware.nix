{ stdenv, boost, fetchFromGitHub, gcc-arm-embedded, sbv4-libopencm3 }:

stdenv.mkDerivation {
  name = "sbv4-firmware";
  src = fetchFromGitHub {
    owner = "srobo";
    repo = "servo-v4-fw";
    fetchSubmodules = true;
    rev = "3e5d3bafb18ed80096c7831801d6a4d3f3e598de";
    sha256 = "1nkyci9dvrv7ail86dak7hc8z2s84sh8xw7n3glcba2rh7ahkzmx";
  };
  buildInputs = [ boost gcc-arm-embedded sbv4-libopencm3 ];
  LIBOPENCM3 = "${sbv4-libopencm3}/arm-none-eabi";
  installPhase = ''
    install -D -m 0644 -t $out/images sbv4.{bin,elf} sbv4_noboot.bin sbv4_test.{bin,elf}
    install -D -m 0644 -t $out/oocd oocd/sbv4.cfg

    mkdir -p $out/bin
    cat >$out/bin/sbv4-firmware-dir <<EOF
      #!${stdenv.shell}
      echo $out/images
    EOF
    chmod +x $out/bin/sbv4-firmware-dir
  '';

  meta = with stdenv.lib; {
    #license = XXX;  # FIXME
    description = "Firmware for the SBV4 power board";
    homepage = https://github.com/srobo/servo-v4-fw;
  };
}
