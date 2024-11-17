let
  # Change to this if you want to use your configured channel
  #  nixpkgs = <nixpkgs>;

  # Otherwise, use nixos-24.05 from 2024-09-29:
  nixpkgs = fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/fbca5e7.tar.gz";
    sha256 = "07wa6y7q4ql0x1jj08dignak2lra003inf2cxl4xxvyqdsspshp3";
  };
  pkgs = import nixpkgs {};
  home-manager = import packages/home-manager.nix pkgs;

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
