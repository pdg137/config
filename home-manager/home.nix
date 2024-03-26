{ config, pkgs, extra-packages ? [], emacs ? pkgs.emacs }:

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
    pkgs.ncurses
    pkgs.tmux
    pkgs.ispell
    pkgs.nix
    ((import ./packages/config-version.nix) pkgs)
    ((import ./my-scripts.nix) pkgs)
    (emacs.pkgs.withPackages (epkgs: with epkgs; [
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
      clipetty
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
  };
}
