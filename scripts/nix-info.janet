#!/usr/bin/env janet

(use sh)

($ nix-env -qaA nixpkgs. ^ (in (dyn *args*) 1) --json --meta
 | jq -r `.[] | .name + " " + .meta.description,
          "",
          (.meta.longDescription | rtrimstr("\n"))`)
