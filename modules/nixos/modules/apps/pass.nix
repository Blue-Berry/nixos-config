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
      browserpass
      passff-host
    ];

    programs.browserpass.enable = true;

    programs.firefox.nativeMessagingHosts.packages = [
      pkgs.passff-host
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
      settings = {
        default-cache-ttl = 604800; # 7 days
        max-cache-ttl = 604800; # 7 days
      };
    };
  };
}
