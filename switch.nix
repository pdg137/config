let
  # Change to this if you want to use your configured channel
  #  nixpkgs = <nixpkgs>;

  # nixos-25.11 from 2025-11-30:
  nixpkgs = fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/d542db7.tar.gz";
    sha256 = "0x6wjmpzxrrlmwwq8v3znpyr1qs5m1vf9bdgwwlq0lr5fl8l4v67";
  };
  pkgs = import nixpkgs {};
  home-manager = pkgs.home-manager;

  # Makes a script installed in the nix store.
  make-static-script = file:
    let
      repo = pkgs.stdenv.mkDerivation {
       name = "my-home-manager";
       src = pkgs.lib.cleanSource ./.;
       installPhase = "cp -r $src $out";
      };
    in
      make-script "${repo}/${file}";

  # Makes a script referencing files in this folder (so you can
  # edit them and run the script to switch immediately.)
  make-script = file:
    let
      config_version = builtins.getEnv "CONFIG_VERSION";
      export_config_version =
        if config_version == ""
        then ''export CONFIG_VERSION="`git describe --long --tags --always --dirty`"''
        else ''export CONFIG_VERSION="${config_version}"'';

      script = pkgs.writeText "script" ''
        case $1 in
          update)
            mode=`basename ${file} .nix`
            read -p "Press enter to update $0 in $mode mode..."
            set -ex
            nix-build switch.nix -A $mode -o $0
            exit 0;;
          "")
            ;;
          *)
            echo "Usage: $0 [update]"
            exit 1;;
        esac

        ${export_config_version}
        echo "Config version: $CONFIG_VERSION"
        read -p "Press enter to switch configuration to ${file}..."
        export HOME_MANAGER_CONFIG="${file}"
        export NIX_PATH=nixpkgs="${nixpkgs}"
        ${home-manager}/bin/home-manager switch'';
    in
      pkgs.stdenv.mkDerivation {
        name = "switch";
        dontUnpack = true;
        installPhase = ''
          cp ${script} $out
          chmod a+x $out'';
      };
in
  {
    desktop = make-script "desktop.nix";
    server = make-script "server.nix";
    server-static = make-static-script "server.nix";
    none = assert false; "Build with -A <type>";
  }
