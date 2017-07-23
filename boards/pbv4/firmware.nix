{ stdenv, boost, fetchFromGitHub, gcc-arm-embedded, pbv4-libopencm3 }:

stdenv.mkDerivation {
  name = "pbv4-firmware";
  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "power-v4-fw";
    fetchSubmodules = true;
    rev = "2795f9bd390fe409986ee1642762408a8a98edc8";
    sha256 = "11k3a6a835bqxslsggnmnn6dg8kv3hsgcdnw7w55342m7qd7dih1";
  };
  buildInputs = [ boost gcc-arm-embedded pbv4-libopencm3 ];
  LIBOPENCM3 = "${pbv4-libopencm3}/arm-none-eabi";
  installPhase = ''
    install -D -m 0644 -t $out/images pbv4.{bin,elf} pbv4_noboot.bin pbv4_test.{bin,elf}
    install -D -m 0644 -t $out/oocd oocd/pbv4.cfg
  '';
}
