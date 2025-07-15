{
  config,
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = toString (
        pkgs.writeShellScript "hyprland-wrapper" ''
          trap 'systemctl --user stop hyprland-session.target; sleep 1' EXIT
          exec Hyprland >/dev/null
        ''
      );
      user = config.userSettings.username;
    };
  };
  environment.etc."greetd/environments".text = "Hyprland";
}
