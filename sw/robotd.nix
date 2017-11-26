{ stdenv, fetchFromGitHub, libusb1, python35Packages, sb-vision }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "9e15ccf84b82a2ec5063bb7fe71038dfd4796579";
    sha256 = "19rrf23yl29nyyjb82jbqx766vh9xkgnagl9x5cvkg7kplf0vhd4";
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
