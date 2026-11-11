{
  description = "Your new nix config";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
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
    niri = {
      url = "github:sodiboo/niri-flake/very-refactor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.url = "github:niri-wm/niri";
    };
    niri-config.follows = "niri";

    stylix.url = "github:danth/stylix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nixCats.url = "./nvim/";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # nix-ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    # nix-ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";

    dune-src = {
      url = "github:ocaml/dune?ref=main";
      flake = false;
    };

    # opencode-nix.url = "github:anomalyco/opencode";

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

    codex-nix = {
      url = "github:SecBear/codex-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-monitor = {
      url = "github:antonjah/nix-monitor";
    };
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    importFeatures = dir:
      lib.concatLists (lib.mapAttrsToList (name: kind: let
        path = dir + "/${name}";
      in
        if kind == "directory"
        then importFeatures path
        else if kind == "regular" && lib.hasSuffix ".nix" name
        then [path]
        else []) (builtins.readDir dir));
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = importFeatures ./features;
      systems = ["aarch64-linux" "i686-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"];
    };
}
