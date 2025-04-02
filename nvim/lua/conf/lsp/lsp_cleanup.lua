-- Close any lsp servers that have their root_dir set to nil
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_clients())
    for _, c in ipairs(client) do
      if c.root_dir == nil then
        vim.lsp.stop_client(c.id)
      end
    end
  end,
})
