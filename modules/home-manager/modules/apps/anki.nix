{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.anki;
in {
  options.homeModules.apps.anki = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.homeModules.apps.enable;
      defaultText = lib.literalExpression "config.homeModules.apps.enable";
      description = "Enable Anki";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "liamandberry@gmail.com";
      description = "Username for Anki";
    };
    darkMode = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use dark mode";
    };
    keyFile = lib.mkOption {
      type = lib.types.path;
      default = "/home/liam/.config/ankiKey.txt";
      description = "Path to Anki key file";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.anki = {
      enable = true;
      theme =
        if cfg.darkMode
        then "dark"
        else "light";
      sync = {
        autoSync = true;
        username = cfg.username;
        syncMedia = true;
        keyFile = cfg.keyFile;
      };
      addons = [
        pkgs.ankiAddons.review-heatmap
        pkgs.ankiAddons.passfail2
        # pkgs.ankiAddons.recolor
        (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
          pname = "onigiri";
          version = "1.0.7.1";
          src = pkgs.fetchFromGitHub {
            owner = "thepeacemonk";
            repo = "Onigiri";
            rev = "v.${finalAttrs.version}-beta";
            hash = "sha256-VVBZk+AUKk90+weFiHqGqP3uzXUP+j+lc/0HWLO8uco=";
          };
          sourceRoot = "${finalAttrs.src.name}";
          postPatch = let
            xdgBase = ''os.path.expanduser("~"), ".local", "share", "anki-onigiri"'';
          in ''
            # Redirect user_files to writable XDG directory instead of read-only Nix store
            substituteInPlace fonts.py \
              --replace-fail 'os.path.join(addon_path, "user_files", "fonts")' \
                'os.path.join(${xdgBase}, "fonts")'
            substituteInPlace settings.py \
              --replace-fail 'os.path.join(self.addon_path, "user_files"' \
                'os.path.join(${xdgBase}' \
              --replace-fail 'os.path.join(self.addon_path, gallery['"'"'folder'"'"'])' \
                'os.path.join(${xdgBase}, gallery['"'"'folder'"'"'].removeprefix("user_files/"))'
            substituteInPlace config.py \
              --replace-fail "os.path.join(current_dir, 'user_files')" \
                'os.path.join(${xdgBase})'
          '';
        }))
      ];
    };
    stylix.targets.anki = {
      enable = true;
      colors.enable = false;
    };
  };
}
