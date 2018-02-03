{ fetchFromGitHub, opencv, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "sb-vision-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "sb-vision";
    rev = "48cfcb28b1367dce962b0f9f36471f306b973b97";
    sha256 = "1xaxm0k43hj4dckmc0mrg2qyf8dbrxi07qj6cmg64dxqyjlydbi2";
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
