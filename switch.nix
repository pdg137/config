let
  # Change to this if you want to use your configured channel
  #  nixpkgs = <nixpkgs>;

  # Otherwise, use nixos-25.05 from 2025-05-29:
  nixpkgs = fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/7848cd8.tar.gz";
    sha256 = "0lscn3m2z2zs29k17c8901cpfgv6j4rrac1bpmslycr6mz8i64wb";
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
            set -x
            nix-build switch.nix -A $mode -o $0
            { set +x; } 2>/dev/null
            ;;
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
