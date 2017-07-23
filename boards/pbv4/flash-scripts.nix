{ fetchFromGitHub, makeWrapper, pbv4-firmware, perl, stdenv, stm32flash }:

stdenv.mkDerivation {
  name = "pbv4-flash-scripts";

  src = fetchFromGitHub {
    owner = "sourcebots";
    repo = "tools";
    rev = "31acfdb2842025f535084f7f62d251ec1cab17b7";
    sha256 = "12fjvd5y3bglicxavixjjjq29icyxm1r367p2qg1lgqqb3niw6hf";
  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    install -D -m 0755 bin/pbv4-flash-uart $out/bin/pbv4-flash-uart
    install -D -m 0755 bin/pbv4-bake-serial-num $out/bin/pbv4-bake-serial-num
    wrapProgram $out/bin/pbv4-flash-uart --argv0 pbv4-flash-uart --prefix PATH : ${stdenv.lib.makeBinPath [ perl stm32flash ]}
    wrapProgram $out/bin/pbv4-bake-serial-num --argv0 pbv4-bake-serial-num --prefix PATH : ${stdenv.lib.makeBinPath [ perl ]}
  '';
}
