{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.greeter.greetdHyprland;
in
{
  options.nixosModules.greeter.greetdHyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.greeter.enable;
      defaultText = lib.literalExpression "config.nixosModules.greeter.enable";
      description = "Enable greetd configured to launch Hyprland";
    };

    username = lib.mkOption {
      type = lib.types.str;
      default = "liam";
      description = "Username for greetd default session";
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = toString (
          pkgs.writeShellScript "hyprland-wrapper" ''
            trap 'systemctl --user stop hyprland-session.target; sleep 1' EXIT
            exec Hyprland >/dev/null
          ''
        );
        user = cfg.username;
      };
    };
    environment.etc."greetd/environments".text = "Hyprland";
  };
}
