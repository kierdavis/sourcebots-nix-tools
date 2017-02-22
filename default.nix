let
  pkgs = import <nixpkgs> {};
in
  rec {
    power.libopencm3 = pkgs.callPackage ./power/libopencm3 {};
    power.firmware = pkgs.callPackage ./power/firmware { libopencm3 = power.libopencm3; };
    power.flash = pkgs.callPackage ./power/flash { powerFirmware = power.firmware; };

    motor.libopencm3 = pkgs.callPackage ./motor/libopencm3 {};
    motor.firmware = pkgs.callPackage ./motor/firmware { libopencm3 = motor.libopencm3; };
    motor.flash = pkgs.callPackage ./motor/flash { motorFirmware = motor.firmware; };
  }
