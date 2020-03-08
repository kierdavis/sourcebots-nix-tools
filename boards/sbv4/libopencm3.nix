# Build libopencm3 for the SBV4 firmware.

{ fetchFromGitHub, gcc-arm-embedded, python2, stdenv }:

import ../../build-support/libopencm3.nix {
  inherit gcc-arm-embedded python2 stdenv;
  name = "sbv4-libopencm3";
  src = fetchFromGitHub {
    owner = "libopencm3";
    repo = "libopencm3";
    rev = "283d8cc7d2acbfc873897e886658364b12fc5e3b";
    sha256 = "1qbj4bv25bzwqqhi9vscynbn6309lfklahbg7gy1sjqvqmyjjf0y";
  };
}
