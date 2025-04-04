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
		print("not a valid buffer for lsp")
		return
	end
	vim.lsp.enable({ server_name })
	local lsp_clients = vim.lsp.get_clients()
	local client_running = false
	for _, client in pairs(lsp_clients) do
		if client.name == server_name then
			print("client already running")
			client_running = true
		end
	end
	if not client_running then
		print("starting client")
		local started_lsp =vim.lsp.start(vim.lsp.config[server_name], {
			_root_markers = vim.lsp.config[server_name].root_markers,
			reuse_client = function(client, config)
				if client.name == config.name then
					return true
				end
				return false
			end,
		})
		if started_lsp == nil and fallback_server ~= nil then
			print("starting fallback client")
			M.enable_and_start(fallback_server)
		end
	end
end

return M
