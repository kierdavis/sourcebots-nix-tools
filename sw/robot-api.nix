{ stdenv, fetchFromGitHub, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "robot-api-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robot-api";
    rev = "348c5fe44b09e74e61e282f6aed379b56b1039a2";
    sha256 = "0nsnpnw7r8nv1kf7az791gj3bjwjyz0ybdqvqhm8inw0b77kd881";
  };

  buildInputs = [];

  propagatedBuildInputs = [];

  doCheck = false;
}
