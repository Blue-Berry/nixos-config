{lib, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      default-fg = lib.mkForce "rgba(202,211,245,1)";
      default-bg = lib.mkForce "rgba(36,39,58,1)";
      completion-bg = lib.mkForce "rgba(54,58,79,1)";
      completion-fg = lib.mkForce "rgba(202,211,245,1)";
      completion-highlight-bg = lib.mkForce "rgba(87,82,104,1)";
      completion-highlight-fg = lib.mkForce "rgba(202,211,245,1)";
      completion-group-bg = lib.mkForce "rgba(54,58,79,1)";
      completion-group-fg = lib.mkForce "rgba(138,173,244,1)";
      statusbar-fg = lib.mkForce "rgba(202,211,245,1)";
      statusbar-bg = lib.mkForce "rgba(54,58,79,1)";
      notification-bg = lib.mkForce "rgba(54,58,79,1)";
      notification-fg = lib.mkForce "rgba(202,211,245,1)";
      notification-error-bg = lib.mkForce "rgba(54,58,79,1)";
      notification-error-fg = lib.mkForce "rgba(237,135,150,1)";
      notification-warning-bg = lib.mkForce "rgba(54,58,79,1)";
      notification-warning-fg = lib.mkForce "rgba(250,227,176,1)";
      inputbar-fg = lib.mkForce "rgba(202,211,245,1)";
      inputbar-bg = lib.mkForce "rgba(54,58,79,1)";
      recolor = lib.mkForce "true";
      recolor-lightcolor = lib.mkForce "rgba(36,39,58,1)";
      recolor-darkcolor = lib.mkForce "rgba(202,211,245,1)";
      index-fg = lib.mkForce "rgba(202,211,245,1)";
      index-bg = lib.mkForce "rgba(36,39,58,1)";
      index-active-fg = lib.mkForce "rgba(202,211,245,1)";
      index-active-bg = lib.mkForce "rgba(54,58,79,1)";
      render-loading-bg = lib.mkForce "rgba(36,39,58,1)";
      render-loading-fg = lib.mkForce "rgba(202,211,245,1)";
      highlight-color = lib.mkForce "rgba(87,82,104,0.5)";
      highlight-fg = lib.mkForce "rgba(245,189,230,0.5)";
      highlight-active-color = lib.mkForce "rgba(245,189,230,0.5)";
    };
  };
}
