-- local ok, notify = pcall(require, "notify")
-- if ok then
-- 	notify.setup({
-- 		on_open = function(win)
-- 			vim.api.nvim_win_set_config(win, { focusable = false })
-- 		end,
-- 	})
-- 	vim.notify = notify
-- 	vim.keymap.set("n", "<Esc>", function()
-- 		notify.dismiss({ silent = true })
-- 	end, { desc = "dismiss notify popup and clear hlsearch" })
-- end

require("lze").load({
	{ import = "plugins.oil" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.completion" },
	{ import = "plugins.noice" },
	{ import = "plugins.surround" },
	{ import = "plugins.mini" },
	{ import = "plugins.undotree" },
	{ import = "plugins.theme" },
	{ import = "plugins.markdown" },
	{ import = "plugins.git" },
	{ import = "plugins.flash" },
	{ import = "plugins.auto_indent" },
	{ import = "plugins.languages" },
	{ import = "plugins.terminal" },
	{ import = "plugins.snacks" },
	{
		"trouble.nvim",
		cmd = "Trouble",
		after = function(plugin)
			require("trouble").setup({})
		end,
	},
	{
		"vim-startuptime",
		for_cat = "general.extra",
		cmd = { "StartupTime" },
		before = function(_)
			vim.g.startuptime_event_width = 0
			vim.g.startuptime_tries = 10
			vim.g.startuptime_exe_path = require("nixCatsUtils").packageBinPath
		end,
	},
	{
		"supermaven-nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		after = function(_)
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
				ignore_filetypes = {bigfile = true},
				disable_inline_completion = false, -- disables inline completion for use with cmp
				disable_keymaps = false, -- disables built in keymaps for more manual control
			})
		end,
	},
	{
		"yazi.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		keys = {
			{ "<leader>_", "<cmd>Yazi<cr>", mode = { "n" }, noremap = true, desc = "Open yazi at the current file" },
		},
		after = function(plugin)
			require("yazi").setup({
				-- your config here
				-- see :help yazi.nvim
			})
		end,
	},
	{
		"obsidian.nvim",
		event = "DeferredUIEnter",
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("plenary.nvim")
		end,
		after = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "Knowledge-base",
						path = "~/knowledge-base",
					},
				},
			})
		end,
	},
	{
		"nvim-repl",
		ft = "ocaml",
		keys = {
			{ "<Leader>rc", "<Plug>(ReplSendCell)", mode = "n", desc = "Send Repl Cell" },
			{ "<Leader>rr", "<Plug>(ReplSendLine)", mode = "n", desc = "Send Repl Line" },
			{ "<Leader>rr", "<Plug>(ReplSendVisual)", mode = "x", desc = "Send Repl Visual Selection" },
		},
		after = function(_)
			require("repl").setup({
				filetype_commands = {
					ocaml = { cmd = "dune utop", repl_type = "utop", filetype = "ocaml" },
				},
			})
		end,
	},
	{
		"hex.nvim",
		cmd = {"HexDump", "HexAssemble", "HexToggle"},
		after = function(_)
			require("hex").setup()
		end
	}
})
