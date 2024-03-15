# nix-shell --run 'home-manager switch'
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

in pkgs.mkShell rec {

  name = "home-manager-shell";

  buildInputs = [ home-manager ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${home-manager}"
    export HOME_MANAGER_CONFIG="./home.nix"
  '';

}
