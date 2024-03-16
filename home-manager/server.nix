{ config, pkgs, ... }:

import ./home.nix {
  inherit config;
  inherit pkgs;
}
