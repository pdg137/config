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

  make-script = file:
    pkgs.writeShellScript "switch" ''
      read -p "Press enter to switch configuration to ${file}..."
      export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${home-manager}"
      export HOME_MANAGER_CONFIG="${file}"
      ${home-manager}/bin/home-manager switch'';

in
  {
    desktop = make-script "./desktop.nix";
    server = make-script "./server.nix";
    none = assert false; "Build with -A desktop or -A server";
  }
