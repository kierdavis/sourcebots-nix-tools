{ stdenv, powerFirmware, openocd, stm32flash }:

stdenv.mkDerivation {
  inherit powerFirmware openocd stm32flash;
  inherit (stdenv) shell;
  name = "pbv4-flash";
  src = ./.;
  buildPhase = ''
    mkdir -p bin
    imagename=pbv4.elf      substituteAll src/pbv4-flash-oocd.template bin/pbv4-flash-fw-oocd
    imagename=pbv4_test.elf substituteAll src/pbv4-flash-oocd.template bin/pbv4-flash-testfw-oocd
    imagename=pbv4.bin      substituteAll src/pbv4-flash-uart.template bin/pbv4-flash-fw-uart
    imagename=pbv4_test.bin substituteAll src/pbv4-flash-uart.template bin/pbv4-flash-testfw-uart
  '';
  installPhase = ''
    for src in bin/*; do
      dest=$out/bin/$(basename $src)
      install -D -m 0755 $src $dest
    done
  '';
}
