{ stdenv, fetchFromGitHub, libusb1, opencv, python35Packages, sb-vision }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "5f590a3451efeedddb65c12d62232ddbbf1a4b35";
    sha256 = "1f8l5gx2l7h8s6qjj6m7jkri0x66src23dkj49jwsm7v14ii8kb9";
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

  # The unit tests require an actual power board to be connected to the PC.
  doCheck = false;

  # Ugly hack to make libusb header file available as "libusb.h" as well as "libusb-1.0/libusb.h".
  NIX_CFLAGS_COMPILE = "-isystem ${libusb1.dev}/include/libusb-1.0";
}
