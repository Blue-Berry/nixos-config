vim.lsp.config("*", {
  root_markers = { ".git" },
})
-- vim.lsp.enable({
--   "ocamllsp",
--   "gopls",
--   "nixd",
--   "lua_ls",
-- })

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
})

require("lze").load {
  {
    "nvim-lspconfig",
    for_cat = "general.core",
    event = { "FileType" },
    cmd = {
      "LspInfo",
      "LspStart",
      "LspStop",
      "LspRestart",
    },
    on_require = { "lspconfig" },
  }
}
