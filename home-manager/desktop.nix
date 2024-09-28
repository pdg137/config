{ config, pkgs, ... }:

import ./home.nix {
  inherit config;
  inherit pkgs;

  # Add extra packages that we want on a desktop but not
  # on servers.  Graphical applications, games, etc.
  extra-packages = [
    pkgs.gnucash
    pkgs.nethack
    ((import ./packages/micro.nix) pkgs)
    pkgs.noto-fonts-emoji
    pkgs.source-code-pro
    pkgs.font-manager
  ];

  emacs = pkgs.emacs;

  enable_fontconfig = true;
}
