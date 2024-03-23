My home-manager-based config.

To get started on a new server:

1. Install nix
2. Back up and remove your existing `.emacs.d`, `.bashrc`, and `.profile`
3. Clone this repository and go into the `home-manager/` directory.
4. Run `./build.sh desktop` or `./build.sh server`.
5. Run `./switch`.

If you
build it this way, you can edit the configuration and just re-run
`switch` to build and switch to a new profile.  Also, several files
such as the emacs custom-file are linked directly to their editable
versions so you can edit them directly without rebuilding each time.
