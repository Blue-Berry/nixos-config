vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/codeLens') then
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
          vim.lsp.codelens.refresh()
          require("conf.lsp.codelens").refresh_virtlines()
        end,
        buffer = args.buf,
      })

      vim.keymap.set(
        "n",
        "<leader>tt",
        require("conf.lsp.codelens").toggle_virtlines,
        { silent = true, desc = "Toggle code lens", buffer = 0 }
      )
    end
  end,
})

return {
  cmd = { 'ocamllsp' },
  filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
  root_markers = { '*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace' },
  settings = {
    codelens = { enable = true },
    inlayHints = { hintPatternVariables = true, hintLetBindings = true },
    extendedHover = { enable = true },
    syntaxDocumentation = { enable = true },
    merlinJumpCodeActions = { enable = true },
  },
}
