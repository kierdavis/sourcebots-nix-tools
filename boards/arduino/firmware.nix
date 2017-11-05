{ arturo, fetchFromGitHub, stdenv }:

stdenv.mkDerivation rec {
  name = "arduino-firmware";
  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "servo-firmware";
    fetchSubmodules = true;
    rev = "c64ebfec2da95a2eb6df3eb13b37e7a0cacc5327";
    sha256 = "1irfs81pwl3wri33xjncg0r4r1l1pbbld84fb86bymjj2hckx36w";
  };
  buildInputs = [ arturo ];

  device = "uno";

  phases = [ "unpackPhase" "buildPhase" "installPhase" "fixupPhase" ];
  buildPhase = ''
    ano build -m ${device} --cxxflags="-std=gnu++11"
  '';
  installPhase = ''
    install -D -m 0644 -t $out/images .build_ano/${device}/firmware.{elf,hex}

    mkdir -p $out/bin
    cat >$out/bin/arduino-firmware-dir <<EOF
      #!${stdenv.shell}
      echo $out/images
    EOF
    chmod +x $out/bin/arduino-firmware-dir
  '';
}
