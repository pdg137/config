host=$1
result=`./build.sh -A server-static`
nix-copy-closure $host $result
ssh $host nix-store --add-root ~/switch -r $result
