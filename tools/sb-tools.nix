{ fetchFromGitHub, libftdi1, makeWrapper, perl, python, pyserial, stdenv, stm32flash }:

let
  pythonWithPyserial = python.buildEnv.override { extraLibs = [ pyserial ]; };
in

stdenv.mkDerivation {
  name = "tools";
  src = fetchFromGitHub {
    owner = "roboticsoutreach";
    repo = "tools";
    rev = "76ac58e3392c3af34e0677787150790b340e440a";
    sha256 = "09g8hh7fg2qax3bq3a542vy3iqfm27c253i4dvvgk39s10mshqdn";
  };
  buildInputs = [ makeWrapper ];
  installPhase = ''
    install -m 0755 -d $out/bin
    install -m 0755 bin/* -t $out/bin
    install -m 0755 -d $out/share
    install -m 0644 share/* -t $out/share

    wrapProgram $out/bin/bake-serial-num --prefix PATH : ${perl}/bin
    wrapProgram $out/bin/mcv4-flash-fw --prefix PATH : ${stm32flash}/bin
    wrapProgram $out/bin/mcv4-flash-usbeeprom --prefix PATH : ${libftdi1}/bin
    wrapProgram $out/bin/pbv4-flash-fw --prefix PATH : ${stm32flash}/bin
    wrapProgram $out/bin/sbv4-flash-fw --prefix PATH : ${stm32flash}/bin:${pythonWithPyserial}/bin
  '';
}
