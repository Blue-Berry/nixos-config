{
  description = "Your new nix config";
  inputs = {
    # Nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    niri.url = "github:sodiboo/niri-flake";

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz" # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    zen-browser.url = "github:Blue-Berry/zen-browser-flake";
    nixCats.url = "./nvim/";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    nix-ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    nix-ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";

    opencode-nix.url = "github:sst/opencode";

    gowin-eda = {
      url = "github:Blue-Berry/gowin-eda.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "git+file:wallpapers";
      flake = false;
    };

    # Use external janet-lsp package definition
    janet-lsp-nix = {
      url = "github:Blue-Berry/janet-lsp.nix";
      flake = false;
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    solaar,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    systemSettings = {
      hostname = "liam-nixos";
    };
    commonModules = [
      solaar.nixosModules.default
      stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
      ./modules/nixos/modules/defualt.nix
      # Binary cache
      {
        nix.settings = {
          substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
            "https://niri.cachix.org"
            "https://ocaml.cachix.org"
          ];

          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
            "ocaml.cachix.org-1:8iCoF5mD6PVwNKVfdr4lLs3W7KxfQoYEoPpP+f6f4nM="
          ];

          trusted-users = ["root" "@wheel"];
        };
      }
    ];
    commonHomeModules = [
      stylix.homeModules.stylix
      inputs.niri.homeModules.niri
      inputs.niri.homeModules.stylix
      ./modules/home-manager/modules
    ];
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Common modules shared between NixOS and home-manager
    commonModules = import ./modules/common;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      personal = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit (self) inputs outputs;
          inherit systemSettings;
        };
        modules =
          [
            (./. + "/profiles" + "/personal/configuration.nix")
          ]
          ++ commonModules;
      };
      work = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit (self) inputs outputs;
          inherit systemSettings;
        };
        modules =
          [
            (./. + "/profiles" + "/work/configuration.nix")
          ]
          ++ commonModules;
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      personal = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = builtins.attrValues outputs.overlays;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs outputs;
          inherit systemSettings;
        };
        modules =
          [
            (./. + "/profiles" + "/personal/home.nix")
          ]
          ++ commonHomeModules;
      };
      work = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = builtins.attrValues outputs.overlays;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs outputs;
          inherit systemSettings;
        };
        modules =
          [
            (./. + "/profiles" + "/work/home.nix")
          ]
          ++ commonHomeModules;
      };
    };
  };
}
