{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.apps.wireguard;
  userCfg = config.commonModules.system.user;
in {
  options.nixosModules.apps.wireguard = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.apps.enable;
      defaultText = lib.literalExpression "config.nixosModules.apps.enable";
      description = "Enable WireGuard VPN configuration";
    };

    privateKeyFile = lib.mkOption {
      type = lib.types.str;
      default = "${userCfg.homeDirectory}/wireguard-keys/private";
      defaultText = lib.literalExpression ''"''${config.commonModules.system.user.homeDirectory}/wireguard-keys/private"'';
      description = "Path to WireGuard private key file";
    };

    interfaces = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "WireGuard interface configurations";
    };

    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [51820 51821];
      description = "UDP ports to open in firewall for WireGuard";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wireguard-tools
    ];

    networking.firewall = {
      allowedUDPPorts = cfg.allowedUDPPorts;
    };

    # Apply default privateKeyFile to interfaces that don't specify one
    networking.wireguard.interfaces = lib.mapAttrs (name: iface:
      iface // {
        privateKeyFile = iface.privateKeyFile or cfg.privateKeyFile;
      }
    ) cfg.interfaces;
  };
}
