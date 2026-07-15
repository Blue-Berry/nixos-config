{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.system.containers;
in
{
  options.nixosModules.system.containers = lib.mkOption {
    type = lib.types.bool;
    default = config.nixosModules.system.enable;
    defaultText = lib.literalExpression "config.nixosModules.system.enable";
    description = "Enable container support (Docker, Podman)";
  };

  config = lib.mkIf cfg {
    virtualisation = {
      containers.enable = true;
      docker.enable = true;
      podman = {
        enable = true;
        # Adds alias for docker -> podman
        dockerCompat = false;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      docker-compose # start group of containers for dev
      podman-compose # start group of containers for dev
    ];
  };
}
