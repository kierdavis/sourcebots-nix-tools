{ fetchFromGitHub, libftdi1, makeWrapper, perl, stdenv, stm32flash }:

stdenv.mkDerivation {
  name = "tools";
  src = fetchFromGitHub {
    owner = "roboticsoutreach";
    repo = "tools";
    rev = "2fcc2addde775e84e68c902fddd197aea69cfa5b";
    sha256 = "1h3vnq65n1pvadq6cd9ahxnllyrszk9cj5cfs8v7lbpb7af837jb";
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
    wrapProgram $out/bin/sbv4-flash-fw --prefix PATH : ${stm32flash}/bin
  '';
}
