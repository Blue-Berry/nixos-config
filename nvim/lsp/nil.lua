-- Nil LSP config

return {
  cmd = { "nil" },
  root_markers = {
    "flake.nix",
    "flake.lock",
  },
  filetypes = {
    "nix",
  },
  -- Global config options
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nix", "fmt" },
      },
      diagnostics = {
        ignored = {},
      },
      nix = {
        maxMemoryMB = 2560,
      },
      flake = {
        autoArchive = false,
        autoEvalImputs = true,
        nixpkgsInputName = "nixpkgs",
      },
    },
  },
}
