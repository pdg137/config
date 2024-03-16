My home-manager-based config.

To get started on a new server:

1. Install nix
2. Back up and remove your existing `.emacs.d`, `.bashrc`, and `.profile`
3. Run the following:
   ```
   nix-build https://github.com/pdg137/config/archive/refs/heads/master.zip -o switch
   ```
4. Run `./switch`.

This will install a static profile into the nix store and switch to it.

For more options, clone this repository.  In `home-manager/` you can
run for example:

```
nix-build switch.nix -A desktop -o switch
```

to build a command that will switch to the desktop profile.  If you
build it this way, you can edit the configuration and just re-run
`switch` to build and switch to a new profile.  Also, several files
such as the emacs custom-file are linked directly to their editable
versions so you can edit them directly without rebuilding each time.
