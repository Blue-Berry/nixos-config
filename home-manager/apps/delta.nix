{pkgs, ...}: {
  # home.packages = [pkgs.delta];
  programs.delta.enable = true;
  programs.delta.options = {
    features = "decorations";
    line-numbers = true;
    hyperlinks = true;
  };
}
