# Usage examples:
# ./copy.sh my-server
# CONFIG_ARCH=aarch64-linux ./copy.sh raspberrypi

set -e

host=$1
export CONFIG_VERSION="`git describe --long --tags --always --dirty`"
result=`nix-build switch.nix -A server-static`
nix-copy-closure $host $result || nix-copy-closure root@$host $result
ssh $host nix-store --add-root ~/switch -r $result
