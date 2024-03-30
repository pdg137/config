# This pinned and modified version fixes two issues:
#
# 1. The nixos-23.11 version of home-manager was incompatible with
#    nixos-23.11 (fixed in nixpkgs 3173aee).
#
# 2. The source reference was not registered, causing GC to break my
#    home-manager install (fixed in 996a748, not yet merged).
#
# When these issues are resolved perhaps we can stop pinning
# home-manager.

pkgs:
let
  home-manager-src = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    # 23.11 release
    rev = "652fda4ca6dafeb090943422c34ae9145787af37";
    hash = "sha256-cLbLPTL1CDmETVh4p0nQtvoF+FSEjsnJTFpTxhXywhQ=";
  };

  # We need to do this weird thing since otherwise the source link
  # somehow doesn't get picked up.
  # See https://github.com/ryantm/home-manager-template/issues/9
  src-ref-pkg = pkgs.stdenv.mkDerivation {
    name = "source-ref-pkg";
    dontUnpack = true;
    buildPhase = ''
      mkdir $out
      ln -s "${home-manager-src}" $out/src
    '';
  };

  # use this if nixpkgs fails
  home-manager-pinned = pkgs.buildEnv {
    name = "home-manager";
    paths = [
      (import home-manager-src {inherit pkgs;}).home-manager
      src-ref-pkg
    ];
  };
in
  home-manager-pinned
