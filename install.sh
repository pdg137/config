if [ -f ~/.bashrc -a ! -L ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc_old; fi
if [ -f ~/.profile -a ! -L ~/.profile ]; then mv ~/.profile ~/.profile_old; fi
stow --target=$(HOME) */
