# home-manager build
# home-manager switch

{ config, pkgs, ... }:

with {
  # Link some dotfiles to allow editing in place.
  link = config.lib.file.mkOutOfStoreSymlink;
};

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";
  home.stateVersion = "23.11";

  home.packages = [
    #pkgs.gnucash
    #pkgs.nethack
    #pkgs.ruby
    pkgs.ncurses
    ((import ./my-scripts.nix) pkgs)
    (pkgs.emacs.pkgs.withPackages (epkgs: with epkgs; [
      use-package
      nix-mode
      bind-key
      color-theme-sanityinc-solarized
      multiple-cursors
      expand-region
      wgrep
      markdown-mode
      ergoemacs-mode
      bash-completion
    ]))
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".nethackrc".source = dotfiles/nethackrc;
    ".bashrc".source = dotfiles/bashrc.sh;
    ".profile".source = dotfiles/profile.sh;
    ".irbrc".source = dotfiles/irbrc;
    ".tmux.conf".source = dotfiles/tmux.conf;
    ".emacs.d/init.el".source = link dotfiles/init.el;
    ".emacs.d/custom_file.el".source = link dotfiles/custom_file.el;

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
