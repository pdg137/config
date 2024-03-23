export CONFIG_VERSION="`git describe --always --dirty` `date`"
nix-build switch.nix -A "$1" -o switch
