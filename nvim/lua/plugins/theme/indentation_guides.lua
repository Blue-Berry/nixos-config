return {
	"indent-blankline.nvim",
	for_cat = "general.extra",
	event = "DeferredUIEnter",
	after = function(_)
		local highlight = {
			"RainbowViolet",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowYellow",
			"RainbowGreen",
			"RainbowCyan",
			"RainbowRed",
		}
		local hooks = require("ibl.hooks")
		vim.g.rainbow_delimiters = { highlight = highlight }
		require("ibl").setup({
			scope = { highlight = highlight, char = "▎" },
			indent = { char = "▎", tab_char = "▎" },
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
