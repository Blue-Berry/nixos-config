{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.apps.yazi;
  flavourRepo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors:catppuccin-mocha";
    rev = "main";
    sha256 = "sha256-a9Ta0dLuxqay0TwcoAOzcQ0aqm40RyzFxXb25Qf8jcQ=";
  };
in
{
  options.homeModules.apps.yazi = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable Yazi file manager";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      yazi
      rich-cli
      glow
    ];

    # yazi-rs/flavors:catppuccin-mocha
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      # Keep legacy shell wrapper name (stateVersion < 26.05)
      shellWrapperName = "yy";
      flavors = {
        catppuccin-mocha = "${flavourRepo}/catppuccin-mocha.yazi";
        catppuccin-macchiato = "${flavourRepo}/catppuccin-macchiato.yazi";
      };
      theme = {
        flavor = {
          use = "catppuccin-macchiato";
        };
      };
      plugins = {
        glow = pkgs.fetchFromGitHub {
          owner = "Reledia";
          repo = "glow.yazi";
          rev = "main";
          hash = "sha256-bqaFqjlQ/VgMdt2VVjEI8cIkA9THjOZDgNspNicxlbc=";
        };
        rich-preview = pkgs.fetchFromGitHub {
          owner = "AnirudhG07";
          repo = "rich-preview.yazi";
          rev = "main";
          hash = "sha256-sKKdZJxPcbGy9lMhnwbklWEhUjYArVhQyoiH3kuMVzY=";
        };
      };
      settings = {
        tasks = {
          image_alloc = 1610612736; # 1.5GB (tripled from 512MB)
          image_bound = [
            15000
            15000
          ]; # tripled from [5000, 5000]
        };
      };
    };
  };
}
