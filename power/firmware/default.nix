{ stdenv, boost, fetchFromGitHub, gcc-arm-embedded, libopencm3 }:

stdenv.mkDerivation {
  name = "power-firmware";
  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "power-v4-fw";
    fetchSubmodules = true;
    rev = "c609c89d2b70fa1a3ff781a02eb10942157964eb";
    sha256 = "06svznibm8vklhwgv3ivc8z932j7c6p2cd83p3fl8mlaa3rhkjc9";
  };
  buildInputs = [ boost gcc-arm-embedded libopencm3 ];
  LIBOPENCM3 = "${libopencm3}/arm-none-eabi";
  installPhase = ''
    install -D -m 0644 -t $out/images pbv4.{bin,elf} pbv4_noboot.bin pbv4_test.{bin,elf}
    install -D -m 0644 -t $out/oocd oocd/pbv4.cfg
  '';
}
