{ stdenv, fetchFromGitHub, libusb1, python35Packages, sb-vision }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "362d593bfd099d0c6a2bc363e5c0fecdd9b4871e";
    sha256 = "0ymv9jfbnc55sn53slzc8sz3iysp0w9pmv3ssqx2ryydnjiw5bds";
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
