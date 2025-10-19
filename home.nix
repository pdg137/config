{ config, pkgs, extra-packages ? [],
  extra-files ? {},
  emacs ? pkgs.emacs, enable_fontconfig ? false }:

with {
  # Link some dotfiles to allow editing in place.
  link = config.lib.file.mkOutOfStoreSymlink;
};

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "23.11";

  home.packages = [
    pkgs.ruby
    pkgs.python3
    pkgs.ncurses
    pkgs.less # much newer than Ubuntu version; supports my terminals
    pkgs.git # again for terminal support
    pkgs.tmux
    pkgs.ispell
    pkgs.nix
    ((import ./packages/config-version.nix) pkgs)
    ((import ./packages/tenuki.nix) pkgs)
    ((import ./my-scripts.nix) pkgs)
    (emacs.pkgs.withPackages (epkgs: with epkgs; [
      use-package
      nix-mode
      bind-key
      color-theme-sanityinc-solarized
      multiple-cursors
      expand-region
      wgrep
      # this seems to stall compilation forever on my server
      # markdown-mode
      ergoemacs-mode
      bash-completion
      clipetty
      coterm
    ]))
  ] ++ extra-packages;

  home.file = {
    ".nethackrc".source = dotfiles/nethackrc;
    ".bashrc".source = dotfiles/bashrc.sh;
    ".profile".source = dotfiles/profile.sh;
    ".irbrc".source = dotfiles/irbrc;
    ".tmux.conf".source = dotfiles/tmux.conf;
    ".emacs.d/init.el".source = link dotfiles/init.el;
    ".emacs.d/custom_file.el".source = link dotfiles/custom_file.el;
    ".config/htop/htoprc".source = dotfiles/htoprc;
    ".config/micro/settings.json".source = dotfiles/micro-settings.json;
    ".local/share/Anki2/gldriver6".source = dotfiles/anki-gldriver6;
  } // extra-files;

  # This seems silly. Is there a better way to get NIX_PATH set?
  home.sessionVariables = {
    NIX_PATH = builtins.getEnv "NIX_PATH";
  };

  fonts.fontconfig.enable = enable_fontconfig;
}
