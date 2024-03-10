# package up some utility scripts

pkgs:
  pkgs.stdenv.mkDerivation {
    pname = "my-scripts";
    version = "1.0";
    src = ./my-scripts;
    installPhase = ''
      mkdir -p $out/bin
      cp $src/* $out/bin/
      '';
  }
