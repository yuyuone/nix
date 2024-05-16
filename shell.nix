with (import <nixpkgs> {});
let nixos-generators = import (builtins.fetchGit {
  url = "https://github.com/nix-community/nixos-generators";
  rev = "722b512eb7e6915882f39fff0e4c9dd44f42b77e";
}); in
mkShell {
  buildInputs = [ nixos-generators ];
}
