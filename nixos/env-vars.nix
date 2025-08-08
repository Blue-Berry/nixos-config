{userSettings, ...}: {
  environment.sessionVariables = {
    PATH = [
      "/home/liam/.cargo/bin"
      "/home/liam/.cache/rebar3/bin"
      "/home/liam/bin"
    ];
    MU_PROFILE = userSettings.profile;  # Set default profile for mu tool
  };
}
