local map = require("mini.map")
local diagnostic_integration = map.gen_integration.diagnostic({
	error = "DiagnosticFloatingError",
	warn = "DiagnosticFloatingWarn",
	info = "DiagnosticFloatingInfo",
	hint = "DiagnosticFloatingHint",
})
local git_integration = map.gen_integration.gitsigns({
	add = "GitSignsAdd",
	change = "GitSignsChange",
	delete = "GitSignsDelete",
})
local search_integration = map.gen_integration.builtin_search({
	search = "Search",
})
map.setup({ integrations = { diagnostic_integration, git_integration, search_integration } })

-- Create a command `:MapToggle` to toggle the minimap
vim.api.nvim_create_user_command("MapToggle", function(_)
	require("mini.map").toggle()
end, { desc = "Toggle minimap" })
