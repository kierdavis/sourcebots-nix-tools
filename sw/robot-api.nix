{ stdenv, fetchFromGitHub, python35Packages,
  robotd ? null, sb-vision ? null, withTests ? true }:

with stdenv.lib;

assert withTests -> robotd != null;
assert withTests -> sb-vision != null;

python35Packages.buildPythonPackage rec {
  name = "robot-api-${version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "robot-api";
    rev = "4c25111c06faf8d433e91fbf148e229ecbe31bdd";
    sha256 = "0lb2x002hy3map3bjl2d774l6618lkzp409imjnda4pl3ji1vwpz";
  };

  buildInputs = [];

  propagatedBuildInputs = optional withTests [ robotd sb-vision ];
}
