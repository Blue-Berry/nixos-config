-- u/see https://github.com/neovim/nvim-lspconfig/blob/ff6471d4f837354d8257dfa326b031dd8858b16e/lua/lspconfig/util.lua#L23-L28

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		-- Stop the LSP client on invalid buffers
		-- u/see https://github.com/neovim/nvim-lspconfig/blob/ff6471d4f837354d8257dfa326b031dd8858b16e/lua/lspconfig/configs.lua#L97-L99
		if #bufname ~= 0 and not require("conf.lsp.utils").bufname_valid(bufname) then
			if client ~= nil then
				client.stop({force = false})
			end
			return
		end

		-- Here the rest of LSP config
	end,
})
