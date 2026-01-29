{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.homeModules.apps.opencode;
in {
  options.homeModules.apps.opencode = lib.mkOption {
    type = lib.types.bool;
    default = config.homeModules.apps.enable;
    defaultText = lib.literalExpression "config.homeModules.apps.enable";
    description = "Enable OpenCode VSCode launcher";
  };

  config = lib.mkIf cfg {
    programs.opencode = {
      enable = true;
      package = inputs.opencode-nix.packages.${pkgs.system}.default;
      settings = {
        autoshare = false;
        autoupdate = true;
        lsp = {
          ocamllsp = {
            command = ["ocamllsp"];
            extensions = [
              ".ml"
              ".mli"
            ];
          };
          nil = {
            command = ["nil"];
            extensions = [".nix"];
          };
          nixd = {
            command = ["nixd"];
            extensions = [".nix"];
          };
          tinymist = {
            command = ["tinymist"];
            extensions = [".typst"];
          };
        };
        mcp = {
          ocaml-mcp-server = {
            type = "local";
            command = ["ocaml-mcp-server"];
            enabled = true;
          };
        };
        formatter = {
          ocamlformat = {
            command = ["ocamlformat"];
            extensions = [
              ".ml"
              ".mli"
            ];
          };
        };
      };
    };
    stylix.targets.opencode.enable = true;
  };
}
# {
#   "$schema": "https://opencode.ai/config.json",
#   "plugin": ["opencode-openai-codex-auth@4.0.2"],
#   "provider": {
#     "openai": {
#       "options": {
#         "reasoningEffort": "medium",
#         "reasoningSummary": "auto",
#         "textVerbosity": "medium",
#         "include": ["reasoning.encrypted_content"],
#         "store": false
#       },
#       "models": {
#         "gpt-5.1-codex-low": {
#           "name": "GPT 5.1 Codex Low (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "low",
#             "reasoningSummary": "auto",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-medium": {
#           "name": "GPT 5.1 Codex Medium (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "medium",
#             "reasoningSummary": "auto",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-high": {
#           "name": "GPT 5.1 Codex High (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "high",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-max": {
#           "name": "GPT 5.1 Codex Max (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "high",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-max-low": {
#           "name": "GPT 5.1 Codex Max Low (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "low",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-max-medium": {
#           "name": "GPT 5.1 Codex Max Medium (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "medium",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-max-high": {
#           "name": "GPT 5.1 Codex Max High (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "high",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-max-xhigh": {
#           "name": "GPT 5.1 Codex Max Extra High (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "xhigh",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-mini-medium": {
#           "name": "GPT 5.1 Codex Mini Medium (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "medium",
#             "reasoningSummary": "auto",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-codex-mini-high": {
#           "name": "GPT 5.1 Codex Mini High (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "high",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-low": {
#           "name": "GPT 5.1 Low (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "low",
#             "reasoningSummary": "auto",
#             "textVerbosity": "low",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-medium": {
#           "name": "GPT 5.1 Medium (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "medium",
#             "reasoningSummary": "auto",
#             "textVerbosity": "medium",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         },
#         "gpt-5.1-high": {
#           "name": "GPT 5.1 High (OAuth)",
#           "limit": {
#             "context": 272000,
#             "output": 128000
#           },
#           "options": {
#             "reasoningEffort": "high",
#             "reasoningSummary": "detailed",
#             "textVerbosity": "high",
#             "include": ["reasoning.encrypted_content"],
#             "store": false
#           }
#         }
#       }
#     }
#   },
#   "lsp": {
#     "ocamllsp": {
#       "command": ["ocamllsp"],
#       "extensions": [".ml", ".mli"]
#     },
#     "nil": {
#         "command": ["nil"],
#         "extensions": [".nix"]
#     },
#     "nixd": {
#         "command": ["nixd"],
#         "extensions": [".nix"]
#     }
#   },
#   "mcp": {
#     "ocaml-mcp-server": {
#       "type": "local",
#       "command": ["ocaml-mcp-server"],
#       "enabled": true
#     }
#   },
#   "formatter": {
#     "ocamlformat": {
#       "command": ["ocamlformat"],
#       "extensions": [".ml", ".mli"]
#     }
#   }
# }

