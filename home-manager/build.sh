export CONFIG_VERSION="`git describe --always --dirty`"
nix-build switch.nix $@
