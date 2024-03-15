My home-manager-based config.

To get started on a new server, first back up and remove your existing `.emacs`, `.bashrc`, and `.profile`. Then run the following:

```
git clone https://pdg137@github.com/pdg137/config.git
cd config/home-manager
nix-shell --run 'home-manager switch'
```

Running emacs should automatically install all packages from Melpa.
