export CONFIG_VERSION="`git describe --long --tags --always --dirty`"
nix-build switch.nix $@
