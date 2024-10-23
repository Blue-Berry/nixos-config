{pkgs, ...}: let
  flavourRepo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "main";
    sha256 = "sha256-a9Ta0dLuxqay0TwcoAOzcQ0aqm40RyzFxXb25Qf8jcQ=";
  };
in {
  home.packages = with pkgs; [
    yazi
    rich-cli
    glow
  ];

  # yazi-rs/flavors:catppuccin-mocha
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
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
      plugin = {
        prepend_previewers = [
          # { name = "*.md"; run = "glow"; }
          {
            name = "*.csv";
            run = "rich-preview";
          } # for csv files
          {
            name = "*.md";
            run = "rich-preview";
          } # for markdown (.md) files
          {
            name = "*.rst";
            run = "rich-preview";
          } # for restructured text (.rst) files
          {
            name = "*.ipynb";
            run = "rich-preview";
          } # for jupyter notebooks (.ipynb)
          {
            name = "*.json";
            run = "rich-preview";
          } # for json (.json) files
          #    { name = "*.lang_type"; run = "rich-preview"} # for particular language files eg. .py, .go., .lua, etc.
        ];
      };
    };
  };
}
