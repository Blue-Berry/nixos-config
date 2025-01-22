{pkgs, ...}: {
  home.packages = [pkgs.delta];
  programs.git.delta.enable = true;
  programs.git.delta.options = {
    features = "decorations";
    line-numbers = true;
    side-by-side = true;
    hyperlinks = true;
  };
}
