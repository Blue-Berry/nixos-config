{
  dendritic.nixos.optional.greetd-hyprland = (
    {
      lib,
      config,
      pkgs,
      ...
    }: let
      cfg = config.nixosModules.greeter.greetdHyprland;
    in {
      options.nixosModules.greeter.greetdHyprland = {
        username = lib.mkOption {
          type = lib.types.str;
          default = "liam";
          description = "Username for greetd default session";
        };
      };

      config = {
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
  );
}
