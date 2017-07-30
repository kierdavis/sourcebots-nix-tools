{ stdenv, fetchFromGitHub, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "robot-api-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robot-api";
    rev = "df6e4a7f421a75b4e67482ab79431e2868f2178f";
    sha256 = "0ak0x5rycndmk5h1y9nwiqqpw0qj736c3mla4k2i3675v6573pmh";
  };

  buildInputs = [];

  propagatedBuildInputs = [];

  doCheck = false;
}
