# home-manager build
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";
  home.stateVersion = "23.11";

  home.packages = [
    pkgs.gnucash
    pkgs.emacs
    pkgs.nethack
    pkgs.ruby
    ((import ./my-scripts.nix) pkgs)
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".nethackrc".source = dotfiles/nethackrc;
    ".bashrc".source = dotfiles/bashrc;
    ".profile".source = dotfiles/profile;
    ".irbrc".source = dotfiles/irbrc;
    ".tmux.conf".source = dotfiles/tmux.conf;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/paul/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
