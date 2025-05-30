_: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    # Optional: load models on startup
    loadModels = [];
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1030"; # used to be necessary, but doesn't seem to anymore
    };
    rocmOverrideGfx = "10.3.0";
  };

  services.open-webui.enable = true;
}
