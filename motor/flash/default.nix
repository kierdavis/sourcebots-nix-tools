{ stdenv, motorFirmware, openocd, stm32flash }:

stdenv.mkDerivation {
  inherit motorFirmware openocd stm32flash;
  inherit (stdenv) shell;
  name = "mcv4-flash";
  src = ./.;
  buildPhase = ''
    mkdir -p bin
    imagename=mcv4.elf      substituteAll src/mcv4-flash-oocd.template bin/mcv4-flash-fw-oocd
    imagename=mcv4_test.elf substituteAll src/mcv4-flash-oocd.template bin/mcv4-flash-testfw-oocd
    imagename=mcv4.bin      substituteAll src/mcv4-flash-uart.template bin/mcv4-flash-fw-uart
    imagename=mcv4_test.bin substituteAll src/mcv4-flash-uart.template bin/mcv4-flash-testfw-uart
  '';
  installPhase = ''
    for src in bin/*; do
      dest=$out/bin/$(basename $src)
      install -D -m 0755 $src $dest
    done
  '';
}
