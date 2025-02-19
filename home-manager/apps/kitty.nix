{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.kitty];
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      # name = "FiraCode Nerd Font Mono";
      name = "Hasklug Nerd Font Mono";
      size = 10;
    };
    settings = {
      background_opacity = "0.8";
      background_blur = 32;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      active_border_color = "#${config.colorScheme.palette.base07}";
      active_tab_background = "#${config.colorScheme.palette.base0E}";
      background = "#${config.colorScheme.palette.base00}";
      bell_border_color = "#${config.colorScheme.palette.base0A}";
      color0 = "#${config.colorScheme.palette.base03}";
      color1 = "#${config.colorScheme.palette.base08}";
      color10 = "#${config.colorScheme.palette.base0B}";
      color11 = "#${config.colorScheme.palette.base0A}";
      color12 = "#${config.colorScheme.palette.base0D}";
      color14 = "#${config.colorScheme.palette.base0C}";
      color2 = "#${config.colorScheme.palette.base0B}";
      color3 = "#${config.colorScheme.palette.base0A}";
      color4 = "#${config.colorScheme.palette.base0D}";
      color6 = "#${config.colorScheme.palette.base0C}";
      color8 = "#${config.colorScheme.palette.base04}";
      color9 = "#${config.colorScheme.palette.base08}";
      cursor = "#${config.colorScheme.palette.base06}";
      cursor_text_color = "#${config.colorScheme.palette.base00}";
      # foreground = "#cdd6f4";
      inactive_tab_background = "#${config.colorScheme.palette.base01}";
      inactive_tab_foreground = "#${config.colorScheme.palette.base05}";
      mark1_background = "#${config.colorScheme.palette.base07}";
      mark1_foreground = "#${config.colorScheme.palette.base00}";
      mark2_background = "#${config.colorScheme.palette.base0E}";
      mark2_foreground = "#${config.colorScheme.palette.base00}";
      mark3_foreground = "#${config.colorScheme.palette.base00}";
      selection_background = "#${config.colorScheme.palette.base06}";
      selection_foreground = "#${config.colorScheme.palette.base00}";
      url_color = "#${config.colorScheme.palette.base06}";
    };
  };
}
# base01:# mantle
# base02:# surface0
# base03:# surface1
# base04:# surface2
# base05:# text
# base06:# rosewater
# base07:# lavender
# base08:# red
# base09:# peach
# base0A:# yellow
# base0B:# green
# base0C:# teal
# base0D:# blue
# base0E:# mauve
# base0F:# flamingo
# active_border_color        = "#${config.colorScheme.palette.base07}";
# active_tab_background      = "#${config.colorScheme.palette.base0E}";
# active_tab_foreground      = "#${config.colorScheme.palette.11111b}";
# background                 = "#${config.colorScheme.palette.base00}";
# bell_border_color          = "#${config.colorScheme.palette.base0A}";
# color0                     = "#${config.colorScheme.palette.base03}";
# color1                     = "#${config.colorScheme.palette.base08}";
# color10                    = "#${config.colorScheme.palette.base0B}";
# color11                    = "#${config.colorScheme.palette.base0A}";
# color12                    = "#${config.colorScheme.palette.base0D}";
# color13                    = "#${config.colorScheme.palette.f5c2e7}";
# color14                    = "#${config.colorScheme.palette.base0C}";
# color15                    = "#${config.colorScheme.palette.a6adc8}";
# color2                     = "#${config.colorScheme.palette.base0B}";
# color3                     = "#${config.colorScheme.palette.base0A}";
# color4                     = "#${config.colorScheme.palette.base0D}";
# color5                     = "#${config.colorScheme.palette.f5c2e7}";
# color6                     = "#${config.colorScheme.palette.base0C}";
# color7                     = "#${config.colorScheme.palette.bac2de}";
# color8                     = "#${config.colorScheme.palette.base04}";
# color9                     = "#${config.colorScheme.palette.base08}";
# cursor                     = "#${config.colorScheme.palette.base06}";
# cursor_text_color          = "#${config.colorScheme.palette.base00}";
# foreground                 = "#${config.colorScheme.palette.base05}";
# inactive_border_color      = "#${config.colorScheme.palette.6c7086}";
# inactive_tab_background    = "#${config.colorScheme.palette.base01}";
# inactive_tab_foreground    = "#${config.colorScheme.palette.base05}";
# mark1_background           = "#${config.colorScheme.palette.base07}";
# mark1_foreground           = "#${config.colorScheme.palette.base00}";
# mark2_background           = "#${config.colorScheme.palette.base0E}";
# mark2_foreground           = "#${config.colorScheme.palette.base00}";
# mark3_background           = "#${config.colorScheme.palette.74c7ec}";
# mark3_foreground           = "#${config.colorScheme.palette.base00}";
# selection_background       = "#${config.colorScheme.palette.base06}";
# selection_foreground       = "#${config.colorScheme.palette.base00}";
# tab_bar_background         = "#${config.colorScheme.palette.11111b}";
# url_color                  = "#${config.colorScheme.palette.base06}";

