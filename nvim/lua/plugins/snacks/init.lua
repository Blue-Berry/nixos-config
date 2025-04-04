return {
	"snacks.nvim",
	for_cat = {
		cat = "general.extra",
		default = true,
	},
	lazy = false,
	after = function(_)
		require("snacks").setup({
			-- Enabled plugins
			lazygit = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			image = { enabled = false },
			bigfile = { enabled = true },
			dim = { enabled = true },
			debug = require("plugins.snacks.debug"),
		})

		-- Config for dim
		vim.g.dim_state = false
		vim.api.nvim_create_user_command("DimToggle", function(_)
			if vim.g.dim_state then
				vim.g.dim_state = false
				Snacks.dim.disable()
			else
				vim.g.dim_state = true
				Snacks.dim.enable()
			end
		end, { desc = "Dim outside of scope" })
	end,
}
