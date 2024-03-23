pkgs:
  let
    config_version = builtins.getEnv "CONFIG_VERSION";
  in
    pkgs.stdenv.mkDerivation {
      name = "config-version";
      src = ./.;
      buildPhase = ''
        mkdir -p $out/bin
        echo "echo ${config_version}" > $out/bin/config-version
        chmod a+x $out/bin/config-version
        '';
    }
