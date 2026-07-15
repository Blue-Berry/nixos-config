{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.commonModules.styling.stylix;

  # Predefined theme schemes
  themes = {
    catppuccin-mocha = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    catppuccin-frappe = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    catppuccin-latte = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    catppuccin-macchiato = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    tokyo-night-dark = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    tokyo-night-light = "${pkgs.base16-schemes}/share/themes/tokyo-night-light.yaml";
    gruvbox-dark-hard = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    gruvbox-light-hard = "${pkgs.base16-schemes}/share/themes/gruvbox-light-hard.yaml";
    nord = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    dracula = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    custom = {
      base00 = "#0E132C";
      base01 = "#1A2132";
      base02 = "#11112F";
      base03 = "#1B3E49";
      base04 = "#27666C";
      base05 = "#35918B";
      base06 = "#2D292D";
      base07 = "#2F1A31";
      base08 = "#544C52";
      base09 = "#43C8C3";
      base0A = "#6A2D43";
      base0B = "#65604C";
      base0C = "#899681";
      base0D = "#D1CBBD";
      base0E = "#B17F83";
      base0F = "#B43764";
    };
  };
in
{
  # Options for shared stylix configuration
  options.commonModules.styling.stylix = {
    colorScheme = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum (builtins.attrNames themes));
      default = null;
      example = "catppuccin-mocha";
      description = ''
        Color scheme to use. Set to null to derive colors from wallpaper.
        Available schemes: ${lib.concatStringsSep ", " (builtins.attrNames themes)}
      '';
    };

    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "stained-glass-planets.jpg";
      example = "SolarSystem.jpg";
      description = ''
        Wallpaper filename from the wallpapers flake input.
        Available in inputs.wallpapers.
      '';
    };

    polarity = lib.mkOption {
      type = lib.types.enum [
        "dark"
        "light"
      ];
      default = "dark";
      description = "Whether to use dark or light theme";
    };

    cursorTheme = lib.mkOption {
      type = lib.types.str;
      default = "Bibata-Modern-Ice";
      example = "Bibata-Modern-Classic";
      description = "Cursor theme name";
    };

    cursorSize = lib.mkOption {
      type = lib.types.int;
      default = 20;
      example = 24;
      description = "Cursor size in pixels";
    };

    fontName = lib.mkOption {
      type = lib.types.str;
      default = "FiraCode Nerd Font Mono";
      example = "JetBrainsMono Nerd Font";
      description = "Monospace font name to use system-wide";
    };

    fontSize = {
      terminal = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Font size for terminals";
      };

      applications = lib.mkOption {
        type = lib.types.int;
        default = 11;
        description = "Font size for applications";
      };

      desktop = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Font size for desktop";
      };

      popups = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Font size for popups";
      };
    };
  };

  # Configuration based on options
  config = {
    # Apply stylix configuration using the options above
    stylix = {
      image = "${inputs.wallpapers}/${cfg.wallpaper}";

      enable = lib.mkDefault true;
      polarity = cfg.polarity;
      autoEnable = lib.mkDefault true;

      # Only set base16Scheme if a color scheme is explicitly chosen
      base16Scheme = lib.mkIf (cfg.colorScheme != null) (themes.${cfg.colorScheme});

      # Cursor configuration
      cursor = {
        package = lib.mkDefault pkgs.bibata-cursors;
        name = cfg.cursorTheme;
        size = cfg.cursorSize;
      };

      # Font configuration
      fonts = {
        monospace = {
          package = lib.mkDefault pkgs.hello;
          name = cfg.fontName;
        };
        emoji = {
          package = lib.mkDefault pkgs.hello;
          name = cfg.fontName;
        };
        sizes = {
          terminal = cfg.fontSize.terminal;
          applications = cfg.fontSize.applications;
          desktop = cfg.fontSize.desktop;
          popups = cfg.fontSize.popups;
        };
      };
      targets.nixos-icons.enable = true;
    };
  };
}
# https://tinted-theming.github.io/tinted-gallery/
# 3024.yaml
# apathy.yaml
# apprentice.yaml
# ashes.yaml
# atelier-cave-light.yaml
# atelier-cave.yaml
# atelier-dune-light.yaml
# atelier-dune.yaml
# atelier-estuary-light.yaml
# atelier-estuary.yaml
# atelier-forest-light.yaml
# atelier-forest.yaml
# atelier-heath-light.yaml
# atelier-heath.yaml
# atelier-lakeside-light.yaml
# atelier-lakeside.yaml
# atelier-plateau-light.yaml
# atelier-plateau.yaml
# atelier-savanna-light.yaml
# atelier-savanna.yaml
# atelier-seaside-light.yaml
# atelier-seaside.yaml
# atelier-sulphurpool-light.yaml
# atelier-sulphurpool.yaml
# atlas.yaml
# ayu-dark.yaml
# ayu-light.yaml
# ayu-mirage.yaml
# aztec.yaml
# bespin.yaml
# black-metal-bathory.yaml
# black-metal-burzum.yaml
# black-metal-dark-funeral.yaml
# black-metal-gorgoroth.yaml
# black-metal-immortal.yaml
# black-metal-khold.yaml
# black-metal-marduk.yaml
# black-metal-mayhem.yaml
# black-metal-nile.yaml
# black-metal-venom.yaml
# black-metal.yaml
# blueforest.yaml
# blueish.yaml
# brewer.yaml
# bright.yaml
# brogrammer.yaml
# brushtrees-dark.yaml
# brushtrees.yaml
# caroline.yaml
# catppuccin-frappe.yaml
# catppuccin-latte.yaml
# catppuccin-macchiato.yaml
# catppuccin-mocha.yaml
# chalk.yaml
# circus.yaml
# classic-dark.yaml
# classic-light.yaml
# codeschool.yaml
# colors.yaml
# cupcake.yaml
# cupertino.yaml
# da-one-black.yaml
# da-one-gray.yaml
# da-one-ocean.yaml
# da-one-paper.yaml
# da-one-sea.yaml
# da-one-white.yaml
# danqing-light.yaml
# danqing.yaml
# darcula.yaml
# darkmoss.yaml
# darktooth.yaml
# darkviolet.yaml
# decaf.yaml
# deep-oceanic-next.yaml
# default-dark.yaml
# default-light.yaml
# dirtysea.yaml
# dracula.yaml
# edge-dark.yaml
# edge-light.yaml
# eighties.yaml
# embers-light.yaml
# embers.yaml
# emil.yaml
# equilibrium-dark.yaml
# equilibrium-gray-dark.yaml
# equilibrium-gray-light.yaml
# equilibrium-light.yaml
# eris.yaml
# espresso.yaml
# eva-dim.yaml
# eva.yaml
# evenok-dark.yaml
# everforest-dark-hard.yaml
# everforest.yaml
# flat.yaml
# framer.yaml
# fruit-soda.yaml
# gigavolt.yaml
# github.yaml
# google-dark.yaml
# google-light.yaml
# gotham.yaml
# grayscale-dark.yaml
# grayscale-light.yaml
# greenscreen.yaml
# gruber.yaml
# gruvbox-dark-hard.yaml
# gruvbox-dark-medium.yaml
# gruvbox-dark-pale.yaml
# gruvbox-dark-soft.yaml
# gruvbox-light-hard.yaml
# gruvbox-light-medium.yaml
# gruvbox-light-soft.yaml
# gruvbox-material-dark-hard.yaml
# gruvbox-material-dark-medium.yaml
# gruvbox-material-dark-soft.yaml
# gruvbox-material-light-hard.yaml
# gruvbox-material-light-medium.yaml
# gruvbox-material-light-soft.yaml
# hardcore.yaml
# harmonic16-dark.yaml
# harmonic16-light.yaml
# heetch-light.yaml
# heetch.yaml
# helios.yaml
# hopscotch.yaml
# horizon-dark.yaml
# horizon-light.yaml
# horizon-terminal-dark.yaml
# horizon-terminal-light.yaml
# humanoid-dark.yaml
# humanoid-light.yaml
# ia-dark.yaml
# ia-light.yaml
# icy.yaml
# irblack.yaml
# isotope.yaml
# jabuti.yaml
# kanagawa.yaml
# katy.yaml
# kimber.yaml
# lime.yaml
# macintosh.yaml
# marrakesh.yaml
# materia.yaml
# material-darker.yaml
# material-lighter.yaml
# material-palenight.yaml
# material-vivid.yaml
# material.yaml
# measured-dark.yaml
# measured-light.yaml
# mellow-purple.yaml
# mexico-light.yaml
# mocha.yaml
# monokai.yaml
# moonlight.yaml
# mountain.yaml
# nebula.yaml
# nord-light.yaml
# nord.yaml
# nova.yaml
# ocean.yaml
# oceanicnext.yaml
# one-light.yaml
# onedark-dark.yaml
# onedark.yaml
# outrun-dark.yaml
# oxocarbon-dark.yaml
# oxocarbon-light.yaml
# pandora.yaml
# papercolor-dark.yaml
# papercolor-light.yaml
# paraiso.yaml
# pasque.yaml
# phd.yaml
# pico.yaml
# pinky.yaml
# pop.yaml
# porple.yaml
# precious-dark-eleven.yaml
# precious-dark-fifteen.yaml
# precious-light-warm.yaml
# precious-light-white.yaml
# primer-dark-dimmed.yaml
# primer-dark.yaml
# primer-light.yaml
# purpledream.yaml
# qualia.yaml
# railscasts.yaml
# rebecca.yaml
# rose-pine-dawn.yaml
# rose-pine-moon.yaml
# rose-pine.yaml
# saga.yaml
# sagelight.yaml
# sakura.yaml
# sandcastle.yaml
# selenized-black.yaml
# selenized-dark.yaml
# selenized-light.yaml
# selenized-white.yaml
# seti.yaml
# shades-of-purple.yaml
# shadesmear-dark.yaml
# shadesmear-light.yaml
# shapeshifter.yaml
# silk-dark.yaml
# silk-light.yaml
# snazzy.yaml
# solarflare-light.yaml
# solarflare.yaml
# solarized-dark.yaml
# solarized-light.yaml
# spaceduck.yaml
# spacemacs.yaml
# sparky.yaml
# standardized-dark.yaml
# standardized-light.yaml
# stella.yaml
# still-alive.yaml
# summercamp.yaml
# summerfruit-dark.yaml
# summerfruit-light.yaml
# synth-midnight-dark.yaml
# synth-midnight-light.yaml
# tango.yaml
# tarot.yaml
# tender.yaml
# terracotta-dark.yaml
# terracotta.yaml
# tokyo-city-dark.yaml
# tokyo-city-light.yaml
# tokyo-city-terminal-dark.yaml
# tokyo-city-terminal-light.yaml
# tokyo-night-dark.yaml
# tokyo-night-light.yaml
# tokyo-night-moon.yaml
# tokyo-night-storm.yaml
# tokyo-night-terminal-dark.yaml
# tokyo-night-terminal-light.yaml
# tokyo-night-terminal-storm.yaml
# tokyodark-terminal.yaml
# tokyodark.yaml
# tomorrow-night-eighties.yaml
# tomorrow-night.yaml
# tomorrow.yaml
# tube.yaml
# twilight.yaml
# unikitty-dark.yaml
# unikitty-light.yaml
# unikitty-reversible.yaml
# uwunicorn.yaml
# vesper.yaml
# vice.yaml
# vulcan.yaml
# windows-10-light.yaml
# windows-10.yaml
# windows-95-light.yaml
# windows-95.yaml
# windows-highcontrast-light.yaml
# windows-highcontrast.yaml
# windows-nt-light.yaml
# windows-nt.yaml
# woodland.yaml
# xcode-dusk.yaml
# zenbones.yaml
# zenburn.yaml
