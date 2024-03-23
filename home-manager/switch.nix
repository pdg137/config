let
  nixpkgs = <nixpkgs>;
  pkgs = import nixpkgs {};

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
    src = ./.;
    buildPhase = ''
      mkdir $out
      ln -s "${home-manager-src}" $out/src
    '';
  };

  home-manager = pkgs.buildEnv {
    name = "home-manager";
    paths = [
      (import home-manager-src {inherit pkgs;}).home-manager
      src-ref-pkg
    ];
  };

  # Makes a script installed in the nix store.
  make-static-script = file:
    let
      repo = pkgs.stdenv.mkDerivation {
       name = "my-home-manager";
       src = ./.;
       installPhase = "cp -r $src $out";
      };
    in
      make-script "${repo}/${file}";

  # Makes a script referencing files in this folder (so you can
  # edit them and run the script to switch immediately.)
  make-script = file:
    pkgs.writeShellScript "switch" ''
      read -p "Press enter to switch configuration to ${file}..."
      export HOME_MANAGER_CONFIG="${file}"
      ${home-manager}/bin/home-manager switch'';

in
  {
    desktop = make-script "desktop.nix";
    server = make-script "server.nix";
    server-static = make-static-script "server.nix";
    none = assert false; "Build with -A <type>";
    home-manager = home-manager;
  }
