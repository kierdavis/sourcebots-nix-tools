{ stdenv, fetchFromGitHub, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "robot-api-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robot-api";
    rev = "f6622663d0ce3e9ca6712dd14fe85acf74a91023";
    sha256 = "0algx6p5my0lhb1hclhmnjcx3z4kdcs8dgz9r1676js6rfsh2aq8";
  };

  buildInputs = [];

  propagatedBuildInputs = [];

  doCheck = false;
}
