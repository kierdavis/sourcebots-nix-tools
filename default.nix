let
  pkgs = import <nixpkgs> {};
in
  rec {
    power.libopencm3 = pkgs.callPackage ./boards/pbv4/libopencm3.nix {};
    power.firmware = pkgs.callPackage ./boards/pbv4/firmware.nix { pbv4-libopencm3 = power.libopencm3; };
    power.flash = pkgs.callPackage ./boards/pbv4/flash-scripts.nix { pbv4-firmware = power.firmware; };

    motor.libopencm3 = pkgs.callPackage ./boards/mcv4/libopencm3.nix {};
    motor.firmware = pkgs.callPackage ./boards/mcv4/firmware.nix { mcv4-libopencm3 = motor.libopencm3; };
    motor.flash = pkgs.callPackage ./motor/flash { motorFirmware = motor.firmware; };

    sw.robotd = pkgs.callPackage ./sw/robotd {};
  }
