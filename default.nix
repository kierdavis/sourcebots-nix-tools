let
  pkgs = import <nixpkgs> {};
in
  rec {
    pbv4-libopencm3 = pkgs.callPackage ./boards/pbv4/libopencm3.nix {};
    pbv4-firmware = pkgs.callPackage ./boards/pbv4/firmware.nix { inherit pbv4-libopencm3; };

    mcv4-libopencm3 = pkgs.callPackage ./boards/mcv4/libopencm3.nix {};
    mcv4-firmware = pkgs.callPackage ./boards/mcv4/firmware.nix { inherit mcv4-libopencm3; };

    sb-tools = pkgs.callPackage ./tools/sb-tools.nix {};
    sb-vision = pkgs.callPackage ./sw/sb-vision.nix {};
    robotd = pkgs.callPackage ./sw/robotd.nix { inherit sb-vision; };
    robot-api = pkgs.callPackage ./sw/robot-api {};
    robot-api-env = (pkgs.python35.withPackages (ps: [robot-api])).env;

    glob2 = pkgs.callPackage ./lib/glob2.nix {};
    arturo = pkgs.callPackage ./tools/arturo.nix { inherit glob2; };
    arduino-firmware = pkgs.callPackage ./boards/arduino/firmware.nix { inherit arturo; };
  }
