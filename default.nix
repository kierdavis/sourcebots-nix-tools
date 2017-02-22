let
  pkgs = import <nixpkgs> {};
in
  rec {
    power.libopencm3 = pkgs.callPackage ./power/libopencm3 {};
    power.firmware = pkgs.callPackage ./power/firmware { libopencm3 = power.libopencm3; };
    power.flash = pkgs.callPackage ./power/flash { powerFirmware = power.firmware; };
  }
