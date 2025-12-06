{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.system.ports;
in {
  options.nixosModules.system.ports = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.system.enable;
      defaultText = lib.literalExpression "config.nixosModules.system.enable";
      description = "Enable firewall port configuration";
    };

    allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [57621];  # Spotify sync
      example = [80 443 22];
      description = "List of TCP ports to allow through the firewall";
    };

    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [5353];  # mDNS (already handled by wireguard module for 51820)
      example = [53 123];
      description = "List of UDP ports to allow through the firewall";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = cfg.allowedTCPPorts;
    networking.firewall.allowedUDPPorts = cfg.allowedUDPPorts;
  };
}
