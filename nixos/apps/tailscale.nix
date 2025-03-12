{config, ...}: {
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };
  # For DNS
  services.resolved.enable = true;
}
