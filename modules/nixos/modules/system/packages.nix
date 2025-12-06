{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.system.packages;
in {
  options.nixosModules.system.packages = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.system.enable;
    defaultText = lib.literalExpression "config.nixosModules.system.enable";
    description = "Enable essential system packages";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [
      pkgs.vim
      pkgs.wget
      pkgs.zsh
      pkgs.git
      pkgs.usbutils
      pkgs.perf
      pkgs.man-pages
      pkgs.man-pages-posix
      pkgs.nmap
      pkgs.cachix
    ];
  };
}
