# Build libopencm3 for the MCV4 firmware.

{ fetchFromGitHub, gcc-arm-embedded, python2, stdenv }:

import ../../build-support/libopencm3.nix {
  inherit gcc-arm-embedded python2 stdenv;
  name = "mcv4-libopencm3";
  src = fetchFromGitHub {
    owner = "libopencm3";
    repo = "libopencm3";
    rev = "0f29fc8b1be14db4908ee1d377c5e571d0ca6235";
    sha256 = "0s06qgj0rjz0ljd6cd7awwbi6nmpfi1ryrcw5kjpvackz9z0ryd7";
  };
}
