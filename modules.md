Modular NixOS Configuration With Enable/Disable Module Controls

This document explains how to build a modular NixOS setup where you can:

Organize features into separate module files

Enable or disable modules via user config

Automatically load all modules from a directory

Maintain full NixOS option autocomplete in editors like nixd or nil

This pattern works in both flake and non-flake configurations.

1. Directory Structure
.
└── modules/
    ├── foo.nix
    ├── bar.nix
    ├── baz.nix
└── default.nix


Each file in the modules/ directory is a standalone NixOS module.

default.nix automatically imports all modules in that directory.

2. Module Structure (modules/foo.nix)

Every module must declare:

A user-facing option (myModules.<name>.enable)

A conditional configuration block

Example:

{ config, lib, pkgs, ... }:

let
  cfg = config.myModules.foo;
in
{
  options.myModules.foo.enable =
    lib.mkEnableOption "Enable the Foo module";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.foo ];
  };
}

Why this works

Options appear in nixos-options

Editors can autocomplete them

Modules apply configuration only when enabled

3. Auto-Importing Modules (default.nix)

This file loads every .nix file inside the modules/ directory:

{ lib, ... }:

let
  files = builtins.attrNames (builtins.readDir ./modules);

  moduleFiles =
    lib.filter (f: lib.hasSuffix ".nix" f) files;

  importedModules =
    map (f: import (./modules + "/${f}")) moduleFiles;
in
{
  imports = importedModules;
}

What this does

Automatically imports new modules when added

Keeps the main config clean

Preserves option autocomplete because modules are real, static module files

4. Enabling Modules in Your System Config

In configuration.nix or your flake:

{
  imports = [ ./default.nix ];

  myModules.foo.enable = true;
  myModules.bar.enable = false;
  myModules.baz.enable = true;
}


Autocomplete will show:

myModules.foo.enable
myModules.bar.enable
myModules.baz.enable

5. Optional: Reduce Boilerplate With a Helper

You can define a helper module factory:

module-lib.nix
name: configFn: { config, lib, pkgs, ... }:
let
  cfg = config.myModules.${name};
in
{
  options.myModules.${name}.enable =
    lib.mkEnableOption "${name} module";

  config = lib.mkIf cfg.enable (configFn { inherit config lib pkgs; });
}

Usage inside modules/foo.nix
import ../module-lib.nix "foo" ({ pkgs, ... }: {
  environment.systemPackages = [ pkgs.foo ];
})


Reduces repeated patterns in each module.

6. Notes on Autocomplete

Autocomplete works only if options are declared statically.

Therefore:

✔ options.myModules.<name>.enable must exist in each module file
✔ Modules must be imported as actual NixOS modules (not dynamically generated attrsets)

This pattern fully satisfies NixOS option discovery and LSP indexing.

7. Troubleshooting
Autocomplete not working?

Ensure your module includes an option declaration:

options.myModules.<name>.enable = mkEnableOption "...";

Module doesn’t apply settings

Missing conditional:

config = lib.mkIf cfg.enable { ... };

Module not loaded

File must end in .nix.

8. Example Minimal Repo Layout
.
├── flake.nix
├── default.nix
└── modules/
    ├── foo.nix
    ├── bar.nix
    └── baz.nix
