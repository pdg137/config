# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

if [ -e /home/paul/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
    source /home/paul/.nix-profile/etc/profile.d/hm-session-vars.sh
    NIX_LINK="$HOME/.nix-profile"
    # Set up environment.
    # This part should be kept in sync with nixpkgs:nixos/modules/programs/environment.nix
    export NIX_PROFILES="/nix/var/nix/profiles/default $NIX_LINK"

    # Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
    if [ -e /etc/ssl/certs/ca-certificates.crt ]; then # NixOS, Ubuntu, Debian, Gentoo, Arch
        export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
    elif [ -e /etc/ssl/ca-bundle.pem ]; then # openSUSE Tumbleweed
        export NIX_SSL_CERT_FILE=/etc/ssl/ca-bundle.pem
    elif [ -e /etc/ssl/certs/ca-bundle.crt ]; then # Old NixOS
        export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
    elif [ -e /etc/pki/tls/certs/ca-bundle.crt ]; then # Fedora, CentOS
        export NIX_SSL_CERT_FILE=/etc/pki/tls/certs/ca-bundle.crt
    elif [ -e "$NIX_LINK/etc/ssl/certs/ca-bundle.crt" ]; then # fall back to cacert in Nix profile
        export NIX_SSL_CERT_FILE="$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
    elif [ -e "$NIX_LINK/etc/ca-bundle.crt" ]; then # old cacert in Nix profile
        export NIX_SSL_CERT_FILE="$NIX_LINK/etc/ca-bundle.crt"
    fi

    # Only use MANPATH if it is already set. In general `man` will just simply
    # pick up `.nix-profile/share/man` because is it close to `.nix-profile/bin`
    # which is in the $PATH. For more info, run `manpath -d`.
    if [ -n "${MANPATH-}" ]; then
        export MANPATH="$NIX_LINK/share/man:$MANPATH"
    fi

    export PATH="$NIX_LINK/bin:$PATH"
    unset NIX_LINK NIX_LINK_NEW
fi

if [ -e /home/paul/.nix-profile/etc/profile.d/nix.sh ]; then
    source /home/paul/.nix-profile/etc/profile.d/nix.sh
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$INSIDE_EMACS" in
    *,comint) export TERM=ansi;;
esac

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    xterm-direct) color_prompt=yes;;
esac

if [[ $TERM == "xterm-256color" ]]; then
    (infocmp xterm-direct > /dev/null 2>&1) && export TERM=xterm-direct
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# from https://help.github.com/articles/working-with-ssh-key-passphrases/#auto-launching-ssh-agent-on-git-for-windows
env=~/.ssh/agent.env
agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }
# Load agent env if we don't get an env passed in from ssh
if [ ! "$SSH_AUTH_SOCK" ]; then
   agent_load_env
fi
# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    echo 'started ssh-agent'
fi
unset env

export PAGER=
export PATH='/c/Program Files (x86)/Git/bin/':$PATH:~/gitprojects/pololu/system2/bin:~/gitprojects/config/bin:/c/Ruby193/bin:~/bin
#export PS1='\u@\h \w$ '

export TRACK_PURCHASE_PAYMENTS_DIRECTORY=~/gitprojects/pololu/track_purchase_payments
export TRACK_DISTRIBUTORS_DIRECTORY=~/gitprojects/pololu/track_distributors
export TRACK_WEB_CONTENT_DIRECTORY=~/gitprojects/pololu/track_web_content
export TRACK_TAX_DIRECTORY=~/gitprojects/pololu/track_tax

if [ -d /usr/local/share/chruby ]; then
   source /usr/local/share/chruby/chruby.sh
   source /usr/local/share/chruby/auto.sh
fi

# uncomment this for RVM
#[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"  # This loads RVM into a shell session.

export EDITOR=emacs
export GIT_MERGE_AUTOEDIT=no

export PATH=$PATH:"/opt/microchip/xc8/v1.33/bin"
export MICRO_TRUECOLOR=1
