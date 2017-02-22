let
  pkgs = import <nixpkgs> {};
in
  rec {
    libopencm3 = pkgs.callPackage ./libopencm3 {};

    power.firmware = pkgs.callPackage ./power/firmware { libopencm3 = libopencm3; };
    power.flash = pkgs.callPackage ./power/flash { powerFirmware = power.firmware; };
  }
