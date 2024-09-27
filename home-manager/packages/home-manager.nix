# This modified version fixes the issue described in
#
#   https://github.com/nix-community/home-manager/pull/5174
#
# Specifically, the source reference was not registered, causing GC to
# break my home-manager install (fixed in 996a748, not yet merged).

pkgs:
let
  home-manager-src = pkgs.home-manager.src;

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

in
  pkgs.buildEnv {
    name = "home-manager";
    paths = [
      (import home-manager-src {inherit pkgs;}).home-manager
      src-ref-pkg
    ];
  }
