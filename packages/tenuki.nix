#let
#  nixpkgs = fetchTarball {
#    name = "nixpkgs";
#    url = "https://github.com/NixOS/nixpkgs/archive/7848cd8.tar.gz";
#    sha256 = "0lscn3m2z2zs29k17c8901cpfgv6j4rrac1bpmslycr6mz8i64wb";
#  };
#  pkgs = import nixpkgs {};
#in
pkgs:
pkgs.buildGoModule rec {
  pname = "tenuki";
  version = "7dee01d";

  src = pkgs.fetchFromGitHub {
    owner = "ymattw";
    repo = pname;
    rev = version;
    hash = "sha256-XOevej74FJMwLZfS5Hn1XtIW1wtEZOMwUl3Z2w+MbJA=";
  };

  vendorHash = "sha256-4VutDQNvrGtfIsR1rLLHVhyC8gHx4jGNPpdSbtUxwkc=";
}
