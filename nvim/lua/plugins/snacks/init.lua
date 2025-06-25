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
			picker = require("plugins.snacks.picker"),
			debug = require("plugins.snacks.debug"),
			profiler = { enabled = true, pick = { picker = "snacks" } },
			Snacks.toggle.profiler():map("<leader>pp"),
			Snacks.toggle.profiler_highlights():map("<leader>ph"),
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

		-- Toggles
		local snacks_toggle = require("snacks").toggle
		snacks_toggle.profiler():map("<leader>pp")
		snacks_toggle.profiler_highlights():map("<leader>ph")
		snacks_toggle.diagnostics():map("<leader>td")
		snacks_toggle.inlay_hints():map("<leader>th")
	end,
}
