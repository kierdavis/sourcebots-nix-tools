{ fetchFromGitHub, libftdi1, makeWrapper, perl, stdenv, stm32flash }:

stdenv.mkDerivation {
  name = "tools";
  src = fetchFromGitHub {
    owner = "roboticsoutreach";
    repo = "tools";
    rev = "e1e0a09f24ee47db105ea55031fe1d1630aff72d";
    sha256 = "13pbwk209acyvxspk2a5g2jx6czx1vyljlg0j4xsamd1kkyvkkcd";
  };
  buildInputs = [ makeWrapper ];
  installPhase = ''
    install -m 0755 -d $out/bin
    install -m 0755 bin/* -t $out/bin
    install -m 0755 -d $out/share
    install -m 0644 share/* -t $out/share

    wrapProgram $out/bin/mcv4-flash-fw --prefix PATH : ${stm32flash}/bin
    wrapProgram $out/bin/mcv4-flash-usbeeprom --prefix PATH : ${libftdi1}/bin
    wrapProgram $out/bin/pbv4-bake-serial-num --prefix PATH : ${perl}/bin
    wrapProgram $out/bin/pbv4-flash-fw --prefix PATH : ${stm32flash}/bin
  '';
}
