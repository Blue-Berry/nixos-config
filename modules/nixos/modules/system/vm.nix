{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.system.vm;
in
{
  options.nixosModules.system.vm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.system.enable;
      defaultText = lib.literalExpression "config.nixosModules.system.enable";
      description = "Enable virtualization support (QEMU/KVM)";
    };

    username = lib.mkOption {
      type = lib.types.str;
      default = "liam";
      description = "Username to add to libvirtd group";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable dconf (System Management Tool)
    programs.dconf.enable = true;

    # Add user to libvirtd group
    users.users.${cfg.username}.extraGroups = [ "libvirtd" ];

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      virtio-win
      win-spice
      adwaita-icon-theme
    ];

    # Manage the virtualisation services
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;

    networking = {
      firewall = {
        trustedInterfaces = [ "virbr0" ];
      };
    };
  };
}
