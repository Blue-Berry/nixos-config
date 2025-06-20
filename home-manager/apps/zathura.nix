{pkgs,lib, ...}: {
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
      default-fg = lib.mkForce "#4c4f69";
      default-bg = lib.mkForce "#eff1f5";
      completion-bg = lib.mkForce "#ccd0da";
      completion-fg = lib.mkForce "#4c4f69";
      completion-highlight-bg = lib.mkForce "#575268";
      completion-highlight-fg = lib.mkForce "#4c4f69";
      completion-group-bg = lib.mkForce "#ccd0da";
      completion-group-fg = lib.mkForce "#1e66f5";
      statusbar-fg = lib.mkForce "#4c4f69";
      statusbar-bg = lib.mkForce "#ccd0da";
      notification-bg = lib.mkForce "#ccd0da";
      notification-fg = lib.mkForce "#4c4f69";
      notification-error-bg = lib.mkForce "#ccd0da";
      notification-error-fg = lib.mkForce "#d20f39";
      notification-warning-bg = lib.mkForce "#ccd0da";
      notification-warning-fg = lib.mkForce "#fae3b0";
      inputbar-fg = lib.mkForce "#4c4f69";
      inputbar-bg = lib.mkForce "#ccd0da";
      recolor = lib.mkForce "true";
      recolor-lightcolor = lib.mkForce "#eff1f5";
      recolor-darkcolor = lib.mkForce "#4c4f69";
      index-fg = lib.mkForce "#4c4f69";
      index-bg = lib.mkForce "#eff1f5";
      index-active-fg = lib.mkForce "#4c4f69";
      index-active-bg = lib.mkForce "#ccd0da";
      render-loading-bg = lib.mkForce "#eff1f5";
      render-loading-fg = lib.mkForce "#4c4f69";
      highlight-color = lib.mkForce "#57526880";
      highlight-fg = lib.mkForce "#ea76cb80";
      highlight-active-color = lib.mkForce "#ea76cb80";
    };
  };
}
