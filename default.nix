let
  pkgs = import <nixpkgs> {};
in
  rec {
    pbv4-libopencm3 = pkgs.callPackage ./boards/pbv4/libopencm3.nix {};
    pbv4-firmware = pkgs.callPackage ./boards/pbv4/firmware.nix { inherit pbv4-libopencm3; };
    pbv4-flash-scripts = pkgs.callPackage ./boards/pbv4/flash-scripts.nix { inherit pbv4-firmware; };

    mcv4-libopencm3 = pkgs.callPackage ./boards/mcv4/libopencm3.nix {};
    mcv4-firmware = pkgs.callPackage ./boards/mcv4/firmware.nix { inherit mcv4-libopencm3; };
    mcv4-flash-scripts = pkgs.callPackage ./motor/flash { motorFirmware = mcv4-firmware; };

    robotd = pkgs.callPackage ./sw/robotd {};
  }
