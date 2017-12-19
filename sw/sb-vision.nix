{ fetchFromGitHub, opencv, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "sb-vision-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "sb-vision";
    rev = "72e41ad14176b5c8ce40221ff8e8ab1990b7a0e2";
    sha256 = "1ck20mjg5gp7rkym0rci4bk5jkwpq6x375h100km6r92629ys4ih";
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
}
