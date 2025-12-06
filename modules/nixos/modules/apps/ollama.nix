{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.apps.ollama;
in {
  options.nixosModules.apps.ollama = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nixosModules.apps.enable;
      defaultText = lib.literalExpression "config.nixosModules.apps.enable";
      description = "Enable Ollama AI/LLM service";
    };

    acceleration = lib.mkOption {
      type = lib.types.enum ["rocm" "cuda" false];
      default = false;
      example = "rocm";
      description = "GPU acceleration type (rocm for AMD, cuda for NVIDIA, false for CPU-only)";
    };

    amdGpuTarget = lib.mkOption {
      type = lib.types.str;
      default = "gfx1030";
      example = "gfx1100";
      description = "AMD GPU target architecture (gfx1030 = RX 6000 series, gfx1100 = RX 7000 series)";
    };

    rocmOverrideGfx = lib.mkOption {
      type = lib.types.str;
      default = "10.3.0";
      example = "11.0.0";
      description = "ROCm GFX version override";
    };

    loadModels = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["llama2" "codellama"];
      description = "Models to automatically load on startup";
    };

    openWebUI = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Open WebUI interface for Ollama";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = cfg.acceleration;
      loadModels = cfg.loadModels;
      environmentVariables = lib.mkIf (cfg.acceleration == "rocm") {
        HCC_AMDGPU_TARGET = cfg.amdGpuTarget;
      };
      rocmOverrideGfx = lib.mkIf (cfg.acceleration == "rocm") cfg.rocmOverrideGfx;
    };

    services.open-webui.enable = cfg.openWebUI;
  };
}
