local catUtils = require('nixCatsUtils')
if (catUtils.isNixCats and nixCats('lspDebugMode')) then
  vim.lsp.set_log_level("debug")
end

-- lsp and diagnostic settings
vim.lsp.config("*", {
  root_markers = { ".git" },
})
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

 -- required plugins
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
  },
  {
    -- lazydev makes your lsp way better in your config without needing extra lsp configuration.
    "lazydev.nvim",
    for_cat = "neonixdev",
    cmd = { "LazyDev" },
    ft = "lua",
    after = function(_)
      require('lazydev').setup({
        library = {
          { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. '/lua' },
        },
      })
    end,
  },
}

-- run on_attach function when lsp attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    require("conf.lsp.caps-on_attach").on_attach(client, args.buf)
  end,
})
