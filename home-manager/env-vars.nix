{userSettings, ...}: {
  home.sessionVariables = {
    EDITOR = "n";
    BROWSER = "zen";
    TERMINAL = "ghostty";
    MANPAGER = "n +Man!";
    MU_PROFILE = userSettings.profile;  # Set default profile for mu tool
  };

  home.sessionPath = ["$HOME/.config/emacs/bin/"];
}
