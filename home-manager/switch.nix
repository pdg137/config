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

  home-manager = (import home-manager-src {inherit pkgs;}).home-manager;

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
    let
      script = pkgs.writeText "script" ''
        read -p "Press enter to switch configuration to ${file}..."
        export HOME_MANAGER_CONFIG="${file}"
        ${home-manager}/bin/home-manager switch'';
    in
      pkgs.stdenv.mkDerivation {
        name = "switch";
        src = ./.;
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
