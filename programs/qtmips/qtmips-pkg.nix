{ lib, pkgs, system, stdenv, cmake, wrapQtAppsHook, qtbase, qtsvg }:

stdenv.mkDerivation rec {
    name = "QtMips";
    src = pkgs.fetchFromGitHub {
      owner = "cvut";
      repo = "QtMips";
      rev = "3d8ea4a7a2aa4c95e3e270111f6128686203913c";
      hash = "sha256-S1d64m3niAiDtnT8EpgoAUb6shZK/mv8MQM95ytipuI=";
    };
    nativeBuildInputs = [ cmake wrapQtAppsHook ];
    buildInputs = [ qtbase ];
}
