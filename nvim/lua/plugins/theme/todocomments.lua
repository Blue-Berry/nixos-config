return {
	"todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope", "TodoLoclist", "TodoQuickfix" },
	after = function(_)
		require("todo-comments").setup({})
	end,
}
