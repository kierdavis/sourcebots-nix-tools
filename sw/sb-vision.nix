{ fetchFromGitHub, opencv, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "sb-vision-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "sb-vision";
    rev = "ec41d509e03f866cf50ec0dd0fa5d9cafcb59eb1";
    sha256 = "0z8864y6sa0xxxn2jrnih427fss3hhc2r5nadm5g1zqdpg0ps1y5";
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
