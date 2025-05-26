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
		-- TODO: make more lazy
		-- event = "DeferredUIEnter",
		cmd = {
			"ObsidianOpen",
			"ObsidianNew",
			"ObsidianQuickSwitch",
			"ObsidianFollowLink",
			"ObsidianBacklinks",
			"ObsidianTags",
			"ObsidianToday",
			"ObsidianYesterday",
			"ObsidianTomorrow",
			"ObsidianDailies",
			"ObsidianTemplate",
			"ObsidianSearch",
			"ObsidianLink",
			"ObsidianLinkNew",
			"ObsidianLinks",
			"ObsidianExtractNote",
			"ObsidianWorkspace",
			"ObsidianPasteImg",
			"ObsidianRename",
			"ObsidianToggleCheckbox",
			"ObsidianNewFromTemplate",
			"ObsidianTOC",
		},
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("plenary.nvim")
		end,
		after = function()
			local nvim_cmp_enable = false
			local blink_enable = false
			if nixCats("completion") == "cmp" then
				nvim_cmp_enable = true
			end

			if nixCats("completion") == "blink" then
				blink_enable = true
			end
			require("obsidian").setup({
				workspaces = {
					{
						name = "Knowledge-base",
						path = "~/knowledge-base",
					},
				},
				completion = {
					-- Enables completion using nvim_cmp
					nvim_cmp = nvim_cmp_enable,
					-- Enables completion using blink.cmp
					blink = blink_enable,
					-- Trigger completion at 2 chars.
					min_chars = 2,
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
			{ "<Leader>rt", "<Plug>(ReplToggle)", mode = "x", desc = "Toggle Repl" },
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
		cmd = { "HexDump", "HexAssemble", "HexToggle" },
		after = function(_)
			require("hex").setup()
		end,
	},
})
