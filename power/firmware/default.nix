{ stdenv, boost, fetchFromGitHub, gcc-arm-embedded, libopencm3 }:

stdenv.mkDerivation {
  name = "power-firmware";
  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "power-v4-fw";
    fetchSubmodules = true;
    rev = "550b95e5dbf66cf962853a9cbbd26b88a8cc66a2";
    sha256 = "0wvi8pcm943xpcl0yf03ppb89wb9fyv6wgjzhkms6g9f6xi7h8dc";
  };
  buildInputs = [ boost gcc-arm-embedded libopencm3 ];
  LIBOPENCM3 = "${libopencm3}/arm-none-eabi";
  installPhase = ''
    install -D -m 0644 -t $out/images pbv4.{bin,elf} pbv4_noboot.bin pbv4_test.{bin,elf}
    install -D -m 0644 -t $out/oocd oocd/pbv4.cfg
  '';
}
