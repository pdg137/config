# A simple utility to record the version of the build and make it
# accessible at runtime.

pkgs:
  let
    config_version = builtins.getEnv "CONFIG_VERSION";
  in
    pkgs.stdenv.mkDerivation {
      name = "config-version";
      dontUnpack = true;
      buildPhase = ''
        mkdir -p $out/bin
        echo "echo ${config_version}" > $out/bin/config-version
        chmod a+x $out/bin/config-version
        '';
    }
