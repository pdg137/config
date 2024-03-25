My home-manager-based config.

To get started on a new server:

1. Install nix
2. Back up and remove your existing `.emacs.d`, `.bashrc`, and `.profile`
3. Clone this repository and go into the `home-manager/` directory.
4. Run `nix-build switch.nix -A desktop -o switch` or `nix-build switch.nix -A server -o switch`.
5. Run `./switch`.

If you
build it this way, you can edit the configuration and just re-run
`switch` to build and switch to a new profile.  Also, several files
such as the emacs custom-file are linked directly to their editable
versions so you can edit them directly without rebuilding each time.

To copy a config to another server without having to check out the
repository there:

1. Add yourself to trusted-users in nix.conf on the server.
2. Run `./copy.sh <hostname>`.
3. Log into the server and run `./switch`.
