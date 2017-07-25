{ stdenv, fetchFromGitHub, libusb1, opencv, python35Packages }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "a25e970e32b2f9104e3e1daf1d71075c530e78d1";
    sha256 = "0k8py1405r9jrbgy2ml5jgmh66zcjr20qn6x7b0wh00bcc9z1mzd";
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
