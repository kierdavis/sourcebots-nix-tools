{ stdenv, fetchFromGitHub, libusb1, opencv, python35Packages }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "ae4ff38d7b189f9b731420166135d51571b83232";
    sha256 = "02kndxjwvvarcycq8zwa24agv3x7510ng53ijwv7a481gmdfrg98";
  };

  buildInputs = [
    libusb1.dev
    opencv.dev
  ];

  propagatedBuildInputs = [
    python35Packages.cffi
    python35Packages.numpy
    python35Packages.pillow
    python35Packages.pyserial
    python35Packages.pyudev
    python35Packages.setproctitle
  ];

  # The unit tests require an actual power board to be connected to the PC.
  doCheck = false;

  # Ugly hack to make libusb header file available as "libusb.h" as well as "libusb-1.0/libusb.h".
  NIX_CFLAGS_COMPILE = "-isystem ${libusb1.dev}/include/libusb-1.0";
}
