{ stdenv, fetchFromGitHub, libusb1, opencv, python35Packages }:

python35Packages.buildPythonApplication rec {
  name = "robotd-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robotd";
    rev = "d2957d9c72047c304ee83ab446ed7c16a29e6d99";
    sha256 = "1mlc9q2fd316ygxffd8r7sdjals9yl07njpqaqd1s2kyjvx3p31r";
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

  patches = [
    ./entrypoint.patch
  ];

  # The unit tests require an actual power board to be connected to the PC.
  doCheck = false;

  # Ugly hack to make libusb header file available as "libusb.h" as well as "libusb-1.0/libusb.h".
  NIX_CFLAGS_COMPILE = "-isystem ${libusb1.dev}/include/libusb-1.0";
}
