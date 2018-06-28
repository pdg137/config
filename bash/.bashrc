# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$INSIDE_EMACS" in
    *,comint) export TERM=ansi;;
esac

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
       # We have color support; assume it's compliant with Ecma-48
       # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
       # a case would tend to support setf rather than setaf.)
       color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

export PAGER=
export PATH='/c/Program Files (x86)/Git/bin/':$PATH:~/gitprojects/pololu/system2/bin:~/gitprojects/config/bin:/c/Ruby193/bin
#export PS1='\u@\h \w$ '

export TRACK_PURCHASE_PAYMENTS_DIRECTORY=~/gitprojects/pololu/track_purchase_payments
export TRACK_DISTRIBUTORS_DIRECTORY=~/gitprojects/pololu/track_distributors
export TRACK_WEB_CONTENT_DIRECTORY=~/gitprojects/pololu/track_web_content
export TRACK_TAX_DIRECTORY=~/gitprojects/pololu/track_tax

if [ -d /usr/local/share/chruby ]; then
   source /usr/local/share/chruby/chruby.sh
   source /usr/local/share/chruby/auto.sh
fi

if [ -e /home/paul/.nix-profile/etc/profile.d/nix.sh ]; then
    source /home/paul/.nix-profile/etc/profile.d/nix.sh
fi

# uncomment this for RVM
#[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"  # This loads RVM into a shell session.

export EDITOR=emacs
export GIT_MERGE_AUTOEDIT=no

export PATH=$PATH:"/opt/microchip/xc8/v1.33/bin"
