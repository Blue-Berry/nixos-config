{
  dendritic.home.commonApps = (
    {
      lib,
      config,
      pkgs,
      ...
    }: {
      config = {
        home.packages = [pkgs.ghostty];
        programs.ghostty = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            initial-command = "tmux";
            background-blur = true;
            background-opacity = 0.7;
            # window-decoration = "server";
            window-decoration = "none";
            app-notifications = "false";
            confirm-close-surface = false;
            shell-integration-features = "ssh-terminfo,ssh-env";
          };
        };
      };
    }
  );
}
