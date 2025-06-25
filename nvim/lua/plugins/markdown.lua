local render_markdown_completion = {}
if nixCats("completion") == "cmp" then
	local cmp = require("cmp")
	render_markdown_completion = cmp.config.sources({
		{ name = "render-markdown" },
	})
elseif nixCats("completion") == "blink" then
	render_markdown_completion = { blink = { enabled = true } }
end
return {
	{
		"render-markdown.nvim",
		for_cat = "general.extra",
		ft = "markdown",
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("mini.nvim")
		end,
		after = function(_)
			require("render-markdown").setup({
				completions = render_markdown_completion,
			})
		end,
	},
	{
		"markdown-preview.nvim",
		-- NOTE: for_cat is a custom handler that just sets enabled value for us,
		-- based on result of nixCats('cat.name') and allows us to set a different default if we wish
		-- it is defined in luaUtils template in lua/nixCatsUtils/lzUtils.lua
		-- you could replace this with enabled = nixCats('cat.name') == true
		-- if you didnt care to set a different default for when not using nix than the default you already set
		for_cat = "general.markdown",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		ft = "markdown",
		keys = {
			{
				"<leader>mp",
				"<cmd>MarkdownPreview <CR>",
				mode = { "n" },
				noremap = true,
				desc = "markdown preview",
			},
			{
				"<leader>ms",
				"<cmd>MarkdownPreviewStop <CR>",
				mode = { "n" },
				noremap = true,
				desc = "markdown preview stop",
			},
			{
				"<leader>mt",
				"<cmd>MarkdownPreviewToggle <CR>",
				mode = { "n" },
				noremap = true,
				desc = "markdown preview toggle",
			},
		},
		before = function(plugin)
			vim.g.mkdp_auto_close = 0
		end,
	},
}
