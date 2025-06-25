{ config, pkgs, ... }:

let
  makeDesktopFile = name: executable:
    pkgs.writeTextFile {
      name = "my-file";
      text = ''
        [Desktop Entry]
        Name=${name}
        Exec=${executable}
        Type=Application
        '';
    };
in

import ./home.nix {
  inherit config;
  inherit pkgs;

  # Add extra packages that we want on a desktop but not
  # on servers.  Graphical applications, games, etc.
  extra-packages = [
    pkgs.anki
    pkgs.gnucash
    pkgs.nethack
    pkgs.bsdgames
    ((import ./packages/micro.nix) pkgs)
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji
    pkgs.source-code-pro
    pkgs.font-manager
    pkgs.xorg.xeyes
  ];

  # emacs29-pgtk (Wayland) has problems with clipboard access
  # see https://emacs.stackexchange.com/questions/74075/emacs-pgtk-for-wsl2-identification-and-clipboard-issues
  emacs = pkgs.emacs;

  enable_fontconfig = true;

  extra-files = {
    ".local/share/applications/xeyes.desktop".source =
      makeDesktopFile "Xeyes" "${pkgs.xorg.xeyes}/bin/xeyes";
    ".local/share/applications/anki.desktop".source =
      makeDesktopFile "Anki" "${pkgs.anki}/bin/anki";
    ".local/share/applications/emacs.desktop".source =
      makeDesktopFile "Emacs client" "${pkgs.emacs}/bin/emacsclient -c";
    ".local/share/applications/gnucash.desktop".source =
      makeDesktopFile "Gnucash" "${pkgs.gnucash}/bin/gnucash";
  };
}
