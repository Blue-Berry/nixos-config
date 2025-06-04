vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = { current_line = true },
	underline = true,
	update_in_insert = false,
})
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

-- Use combination of virt lines and virt text to show diagnostics
local og_virt_text
local og_virt_line
vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
	group = vim.api.nvim_create_augroup("diagnostic_only_virtlines", {}),
	callback = function()
		if og_virt_line == nil then
			og_virt_line = vim.diagnostic.config().virtual_lines
		end

		-- ignore if virtual_lines.current_line is disabled
		if not (og_virt_line and og_virt_line.current_line) then
			if og_virt_text then
				vim.diagnostic.config({ virtual_text = og_virt_text })
				og_virt_text = nil
			end
			return
		end

		if og_virt_text == nil then
			og_virt_text = vim.diagnostic.config().virtual_text
		end

		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

		if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
			vim.diagnostic.config({ virtual_text = og_virt_text })
		else
			vim.diagnostic.config({ virtual_text = false })
		end
	end,
})

local valid_modes = { "VirtLines", "VirtText", "Both", "Enable", "Disable" }
vim.api.nvim_create_user_command("DiagnosticsMode", function(opts)
	local mode = opts.fargs[1]
	if not vim.tbl_contains(valid_modes, mode) then
		vim.notify("Invalid mode. Valid modes: " .. table.concat(valid_modes, ", "), vim.log.levels.ERROR)
		return
	end

	local diag_config = vim.diagnostic.config()
	if not diag_config then
		vim.notify("Diagnostics not enabled", vim.log.levels.ERROR)
		return
	end

	local mode_handlers = {
		VirtLines = function()
			diag_config.virtual_lines = { current_line = false }
			diag_config.virtual_text = false
			return diag_config
		end,
		VirtText = function()
			diag_config.virtual_lines = false
			diag_config.virtual_text = true
			return diag_config
		end,
		Both = function()
			diag_config.virtual_lines = { current_line = true }
			diag_config.virtual_text = true
			return diag_config
		end,
		Enable = function()
			vim.diagnostic.enable(true)
			return diag_config
		end,
		Disable = function()
			vim.diagnostic.enable(false)
			return diag_config
		end,
	}
	local handler = mode_handlers[mode]
	if handler then
		vim.diagnostic.config(handler())
		og_virt_line = nil
	else
		vim.notify("Invalid mode: " .. mode, vim.log.levels.ERROR)
	end
end, {
	nargs = 1,
	complete = function()
		return valid_modes
	end,
	desc = "Change diagnostics mode",
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = vim.api.nvim_create_augroup("diagnostic_redraw", {}),
	callback = function()
		pcall(vim.diagnostic.show)
	end,
})
