{
  # Neither system profile currently installs system-wide Starship. Select this
  # module explicitly in a profile if that changes.
  dendritic.nixos.optional.starship = {pkgs, ...}: {
    environment.systemPackages = [pkgs.starship];
    programs.starship = {
      enable = true;
      presets = ["nerd-font-symbols"];
    };
  };

  # Both standalone home profiles select Starship.
  dendritic.home.commonApps = {pkgs, ...}: {
    home.packages = [pkgs.starship];
    programs.starship = {
      enable = true;
      settings.character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
