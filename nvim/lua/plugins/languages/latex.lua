return {
	{
		"vimtex",
		lazy = false,
		after = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"texpresso.vim",
		ft = "tex",
	},
}
