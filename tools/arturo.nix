{ stdenv, fetchFromGitHub, python2Packages, picocom
, avrdude, arduino-core, avrgcclibc, glob2 }:

python2Packages.buildPythonApplication rec {
  name = "arturo-${version}";
  version = "0.4.5";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "Arturo";
    rev = "921546a4621befc93e218f206fa2f3b6d9749dea";
    sha256 = "0lg6kyw305sd8sbrijvf1a8xv6zf4r8q3n9dkc3c7s6akcnid2n9";
  };

  # TODO: add avrgcclibc, it must be rebuild with C++ support
  propagatedBuildInputs = with python2Packages; [
    arduino-core
    avrdude
    picocom
    configobj
    jinja2
    pyserial
    six
    glob2
  ];

  patchPhase = ''
    echo "Patching Arduino distribution path"
    sed -i 's@/usr/local/share/arduino@${arduino-core}/share/arduino@g' \
        ano/environment.py
    sed -i -e 's@argparse@@' -e 's@ordereddict@@' \
        requirements.txt
    sed -i -e 's@from ordereddict@from collections@' \
        ano/environment.py ano/utils.py

    # Patch the upload command so it uses the correct avrdude
    substituteInPlace ano/commands/upload.py \
      --replace "self.e['avrdude']" "'${avrdude}/bin/avrdude'" \
      --replace "'-C', self.e['avrdude.conf']," ""
  '';
}
