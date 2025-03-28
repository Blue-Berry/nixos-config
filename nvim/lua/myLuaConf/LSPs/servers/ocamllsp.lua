return {
  on_attach = on_attach,
  on_attach = function(client, bufnr)
    local on_attach = require("myLuaConf.LSPs.caps-on_attach").on_attach
    on_attach(client, bufnr)
    -- code lens
    local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
      group = codelens,
      callback = function()
        -- set the highlight for the code lens and inlay hints
        -- :h treesitter-highlight-groups
        -- vim.api.nvim_set_hl(0, "Comment", { link = "@type", italic = true }) -- inlay hints
        -- vim.api.nvim_set_hl(0, "VirtNonText", { link = "@attribute" }) -- code lens
        local colors = require("catppuccin.palettes").get_palette "macchiato"
        vim.api.nvim_set_hl(0, "VirtNonText", { fg = colors.peach, italic = true }) -- code lens
        -- vim.lsp.codelens.refresh()
        require("myLuaConf.LSPs.servers.codelens").refresh_virtlines()
      end,
      buffer = bufnr,
    })

    vim.keymap.set(
      "n",
      "<leader>tt",
      require("myLuaConf.LSPs.servers.codelens").toggle_virtlines,
      { silent = true, desc = "Toggle code lens", buffer = 0 }
    )
  end,
  settings = {
    inlayHints = { enable = true },
    codelens = { enable = true },
    syntaxDocumentation = { enable = true },
  },

  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
  -- root_dir = require("lspconfig.util").root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
  capabilities = require('myLuaConf.LSPs.caps-on_attach').get_capabilities("ocamllsp"),
  get_language_id = function(_, ftype)
    return ftype
  end,
}
