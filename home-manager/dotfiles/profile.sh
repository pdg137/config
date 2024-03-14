# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

export PATH=$PATH:"/opt/microchip/xc8/v1.33/bin"

if [ -e /home/paul/.nix-profile/etc/profile.d/nix.sh ]; then . /home/paul/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
