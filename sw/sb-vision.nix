{ fetchFromGitHub, opencv, python35Packages }:

python35Packages.buildPythonApplication rec {
  name = "sb-vision-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "sb-vision";
    rev = "e8bb8a7006b50bc1cfb6dd434a773199458586c6";
    sha256 = "1dj2c6cs8vihmy9cfm162allnczxcmab1j28n5wcpryd89c662my";
  };

  buildInputs = [
    opencv.dev
  ];

  propagatedBuildInputs = [
    python35Packages.cffi
    python35Packages.numpy
    python35Packages.pillow
    python35Packages.scipy
  ];

  # The unit tests require an actual power board to be connected to the PC.
  doCheck = false;

  # Ugly hack to make libusb header file available as "libusb.h" as well as "libusb-1.0/libusb.h".
  # NIX_CFLAGS_COMPILE = "-isystem ${libusb1.dev}/include/libusb-1.0";
}
