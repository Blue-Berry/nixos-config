local M = {}

-- @param bufname string
M.bufname_valid = function(bufname)
	if
		bufname:match("^/")
		or bufname:match("^[a-zA-Z]:")
		or bufname:match("^zipfile://")
		or bufname:match("^tarfile:")
	then
		return true
	end

	return false
end

-- @param server_name string
M.enable_and_start = function(server_name, fallback_server)
	if not M.bufname_valid(vim.api.nvim_buf_get_name(0)) then
		return
	end
	vim.lsp.enable(server_name)
	local lsp_clients = vim.lsp.get_clients()
	local client_running = false
	for _, client in pairs(lsp_clients) do
		if client.name == server_name then
			client_running = true
		end
	end
	if not client_running then
		local started_lsp = vim.lsp.start(vim.lsp.config[server_name], {
			_root_markers = vim.lsp.config[server_name].root_markers,
			reuse_client = function(client, config)
				if client.name == config.name then
					return true
				end
				return false
			end,
		})
		if started_lsp == nil and fallback_server ~= nil then
			vim.lsp.enable(server_name, false)
			M.enable_and_start(fallback_server)
		end
	end
end

M.enable_and_start_with_fallback = function(server_name)
	M.enable_and_start(server_name, server_name .. "-fallback")
end

M.attached_lsp_name = function(bufnr)
if bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		return client.name
	end
	return nil
end

M.attached_icon = function(bufnr)
	if bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local icons = {
		ocamllsp = "🐫",
		gopls = "",
		rust_analyzer = "",
		lua_ls = "",
	}
	for _, client in ipairs(clients) do
		if icons[client.name] then
			return icons[client.name]
		end
	end
	return "𝕷"
end

return M
