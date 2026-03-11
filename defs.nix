# Some useful defintions.

rec {
  pinTarball = { version, name, url, sha256 }:
    fetchTarball {
      name = "${name}-${version}";
      inherit url;
      inherit sha256;
    };

  pinTarballGithub = { version, name, owner, sha256 }:
    fetchTarball {
      name = "${name}-${version}";
      url = "https://github.com/${owner}/${name}/archive/${version}.tar.gz";
      inherit sha256;
    };

  # nixos-25.11 from 2026-03-05:
  nixpkgs = pinTarballGithub {
    version = "fabb8c9d";
    owner = "NixOS";
    name = "nixpkgs";
    sha256 = "15gvdgdqsxjjihq1r66qz1q97mlcaq1jbpkhbx287r5py2vy38b1";
  };
  pkgs = (import nixpkgs {});

  mkBuildableShell-src = pinTarballGithub {
    version = "39a7d89";
    owner = "pdg137";
    name = "mkBuildableShell";
    sha256 = "1na7c6xzgjqsm2j00ivaqq8pql69d63afd3lisb6mzvj17gfsn3y";
  };
  mkBuildableShell = (import mkBuildableShell-src pkgs);
}


