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
			-- scroll = { enabled = true },
			image = { enabled = false },
			bigfile = { enabled = true },
			dim = { enabled = true },
			input = { enabled = true },
			picker = {},
			debug = require("plugins.snacks.debug"),
			profiler = { enabled = true, pick = { picker = "snacks" } },
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

		vim.keymap.set("n", "<Leader>gg", function()
			require("snacks").lazygit.open()
		end, { desc = "Open Lazygit" })

		vim.keymap.set("n", "<Leader>ps", function()
			Snacks.profiler.scratch()
		end, { desc = "Profiler Scratch Bufer" })
	end,
}
