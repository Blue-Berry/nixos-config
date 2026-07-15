{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.apps.wireguard;
  userCfg = config.commonModules.system.user;
in
{
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
      default = { };
      description = "WireGuard interface configurations (wg-quick style, with optional ips alias)";
    };

    autostart = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether WireGuard interfaces should autostart at boot";
    };

    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [
        51820
        51821
      ];
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

    # Apply default privateKeyFile and map legacy `ips` to wg-quick `address`
    networking.wg-quick.interfaces = lib.mapAttrs (
      name: iface:
      (removeAttrs iface [ "ips" ])
      // {
        privateKeyFile = iface.privateKeyFile or cfg.privateKeyFile;
        address = iface.address or iface.ips or [ ];
        autostart = iface.autostart or cfg.autostart;
      }
    ) cfg.interfaces;
  };
}
