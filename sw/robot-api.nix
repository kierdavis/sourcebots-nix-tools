{ stdenv, fetchFromGitHub, python35Packages }:

python35Packages.buildPythonPackage rec {
  name = "robot-api-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robot-api";
    rev = "190b3aea00e85237cf050daa8f46bb74ab264b03";
    sha256 = "1hn9rblgmdmb06aj7cgh2861qccmb9crm8z79b9896jv6ywig0qi";
  };

  buildInputs = [];

  propagatedBuildInputs = [];

  doCheck = false;
}
