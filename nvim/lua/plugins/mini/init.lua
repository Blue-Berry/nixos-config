return {
	"mini.nvim",
	for_cat = "general.extra",
	event = "DeferredUIEnter",
	dep_of = { "markdown.nvim" },
	on_plugin = { "nvim-treesitter" },
	on_require = { "mini" },
	after = function()
		-- use gcc for toggle comment
		require("mini.comment").setup()
		-- use <alt-h,j,k,l> for moving selected text
		require("mini.move").setup()
		-- autopairs
		require("mini.pairs").setup()
		-- extend f, F, t, T to multiple lines
		-- require("mini.jump").setup()
		-- add animations to vim actions
		-- require('mini.animate').setup()
		require("plugins.mini.map")
		-- highlight words under cursor
		require("mini.cursorword").setup()
		-- Scrollbar and text overview
		require("mini.icons").setup()
	end,
}
