{ fetchFromGitHub, opencv, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "sb-vision-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "sb-vision";
    rev = "672207d86b3d6f00824ffb428762f49d8c352aa4";
    sha256 = "0w8sa33ph0lz1dx9mlszp6k4l73jcq1nw6gi7vr8p7p1wc14n8mw";
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
