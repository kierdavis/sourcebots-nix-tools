{ stdenv, fetchFromGitHub, libusb1, python35Packages, sb-vision }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "4ae124ba4d75f4be64a2b0bbc3f4abd37c94726f";
    sha256 = "1wz2q73ad5abyrlnbvcylhzarm6j0f1f85y36rniv3a6fcdzky9s";
  };

  buildInputs = [
    libusb1.dev
  ];

  propagatedBuildInputs = [
    python35Packages.cffi
    python35Packages.pyserial
    python35Packages.pyudev
    python35Packages.setproctitle
    sb-vision
  ];

  # Ugly hack to make libusb header file available as "libusb.h" as well as "libusb-1.0/libusb.h".
  NIX_CFLAGS_COMPILE = "-isystem ${libusb1.dev}/include/libusb-1.0";
}
