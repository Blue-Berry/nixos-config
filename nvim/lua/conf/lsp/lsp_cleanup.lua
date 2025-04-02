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

-- u/see https://github.com/neovim/nvim-lspconfig/blob/ff6471d4f837354d8257dfa326b031dd8858b16e/lua/lspconfig/util.lua#L23-L28
local bufname_valid = function(bufname)
	if bufname:match '^/' or bufname:match '^[a-zA-Z]:' or bufname:match '^zipfile://' or bufname:match '^tarfile:' then
		return true
	end

	return false
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		-- Stop the LSP client on invalid buffers
		-- u/see https://github.com/neovim/nvim-lspconfig/blob/ff6471d4f837354d8257dfa326b031dd8858b16e/lua/lspconfig/configs.lua#L97-L99
		if (#bufname ~= 0 and not bufname_valid(bufname)) then
			if client ~= nil then
				client.stop()
			end
			return;
		end

		-- Here the rest of LSP config
	end,
})
