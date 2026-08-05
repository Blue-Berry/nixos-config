{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.apps.pass;
in
{
  options.nixosModules.apps.pass = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.apps.enable;
    defaultText = lib.literalExpression "config.nixosModules.apps.enable";
    description = "Enable pass password manager with GPG";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = with pkgs; [
      pass
      gnupg
      passff-host
    ];

    programs.firefox.nativeMessagingHosts.packages = [
      pkgs.passff-host
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };
}
