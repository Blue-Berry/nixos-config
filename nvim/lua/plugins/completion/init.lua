local function faster_get_path(name)
	local path = vim.tbl_get(package.loaded, "nixCats", "pawsible", "allPlugins", "opt", name)
	if path then
		vim.cmd.packadd(name)
		return path
	end
	return nil -- nil will make it default to normal behavior
end

---packadd + after/plugin
---@type fun(names: string[]|string)
local load_w_after_plugin = require("lzextras").make_load_with_afters({ "plugin" }, faster_get_path)

-- NOTE: packadd doesnt load after directories.
-- hence, the above function that you can get from luaUtils that exists to make that easy.

local default = {
	{
		"supermaven-nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		after = function(_)
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
					clear_suggestion = "<C-]>",
					-- 	accept_word = "<C-j>",
				},
				ignore_filetypes = { bigfile = true },
				disable_inline_completion = false, -- disables inline completion for use with cmp
				disable_keymaps = true, -- disables built in keymaps for more manual control
			})
			vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })
		end,
	},
}
local plugins = {}
if nixCats("completion") == "cmp" then
	plugins = {
		{
			"cmp-buffer",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"cmp-cmdline",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"cmp-cmdline-history",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"cmp-nvim-lsp",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			dep_of = { "nvim-lspconfig" },
			load = load_w_after_plugin,
		},
		{
			"cmp-nvim-lsp-signature-help",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"cmp-nvim-lua",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"cmp-path",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"cmp_luasnip",
			for_cat = "general.cmp",
			on_plugin = { "nvim-cmp" },
			load = load_w_after_plugin,
		},
		{
			"friendly-snippets",
			for_cat = "general.cmp",
			dep_of = { "nvim-cmp" },
		},
		{
			"luasnip",
			for_cat = "general.cmp",
			dep_of = { "nvim-cmp" },
			after = function(plugin)
				local luasnip = require("luasnip")
				require("luasnip.loaders.from_vscode").lazy_load()
				luasnip.config.setup({
					region_check_events = "CursorHold,InsertLeave,InsertEnter",
					-- those are for removing deleted snippets, also a common problem
					delete_check_events = "TextChanged,InsertEnter",
				})

				local ls = require("luasnip")
				vim.keymap.set({ "i", "s" }, "<M-n>", function()
					if ls.choice_active() then
						ls.change_choice(1)
					end
				end)

				-- LuaSnip Snippet History Fix (Seems to work really well, I think.)
				local luasnip_fix_augroup = vim.api.nvim_create_augroup("MyLuaSnipHistory", { clear = true })
				vim.api.nvim_create_autocmd("ModeChanged", {
					pattern = "*",
					callback = function()
						if
							(
								(vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
								or vim.v.event.old_mode == "i"
							)
							and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
							and not require("luasnip").session.jump_active
						then
							require("luasnip").unlink_current()
						end
					end,
					group = luasnip_fix_augroup,
				})
			end,
		},
		{
			"nvim-cmp",
			for_cat = "general.cmp",
			-- cmd = { "" },
			event = { "DeferredUIEnter" },
			on_require = { "cmp" },
			-- ft = "",
			-- keys = "",
			-- colorscheme = "",
			after = function(_)
				-- [[ Configure nvim-cmp ]]
				-- See `:help cmp`
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				local lsp_utils = require("conf.lsp.utils")
				cmp.setup({
					formatting = {
						fields = { "kind", "abbr", "menu" },
						format = function(entry, vim_item)
							if lsp_utils.attached_lsp_name() == "ocamllsp" then
								vim_item.kind = require("plugins.completion.ocaml").cmp_kinds[vim_item.kind]
							end
							local lsp_icon = lsp_utils.attached_icon(0)
							vim_item.menu = ({
								buffer = "🅱",
								nvim_lsp = lsp_icon,
								luasnip = "㊊",
								supermaven = "",
							})[entry.source.name]
							return vim_item
						end,
					},
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-p>"] = cmp.mapping.scroll_docs(-4),
						["<C-n>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete({}),
						["<CR>"] = cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						}),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_locally_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),

					sources = cmp.config.sources({
						-- The insertion order influences the priority of the sources
						{ name = "supermaven" },
						{
							name = "nvim_lsp" --[[ , keyword_length = 3 ]],
						},
						{
							name = "nvim_lsp_signature_help" --[[ , keyword_length = 3  ]],
						},
						{ name = "path" },
						{ name = "luasnip" },
						{ name = "buffer" },
					}),
					enabled = function()
						return vim.bo[0].buftype ~= "prompt"
					end,
					experimental = {
						native_menu = false,
						ghost_text = false,
					},
				})

				cmp.setup.filetype("lua", {
					sources = cmp.config.sources({
						{ name = "supermaven" },
						{ name = "nvim_lua" },
						{
							name = "nvim_lsp" --[[ , keyword_length = 3  ]],
						},
						{
							name = "nvim_lsp_signature_help" --[[ , keyword_length = 3  ]],
						},
						{ name = "path" },
						{ name = "luasnip" },
						{ name = "buffer" },
					}),
					{
						{
							name = "cmdline",
							option = {
								ignore_cmds = { "Man", "!" },
							},
						},
					},
				})

				-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "supermaven" },
						{
							name = "nvim_lsp_document_symbol" --[[ , keyword_length = 3  ]],
						},
						{ name = "buffer" },
						{ name = "cmdline_history" },
					},
					view = {
						entries = { name = "wildmenu", separator = "|" },
					},
				})

				-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "cmdline" },
						-- { name = 'cmdline_history' },
						{ name = "path" },
					}),
				})
			end,
		},
	}
elseif nixCats("completion") == "blink" then
	plugins = {
		{
			"friendly-snippets",
			for_cat = "general.cmp",
			dep_of = { "luasnip", "blink.cmp" },
		},
		{
			"luasnip",
			for_cat = "general.cmp",
			dep_of = { "blink.cmp" },
			after = function(_)
				local luasnip = require("luasnip")
				require("luasnip.loaders.from_vscode").lazy_load()
				luasnip.config.setup({
					region_check_events = "CursorHold,InsertLeave,InsertEnter",
					-- those are for removing deleted snippets, also a common problem
					delete_check_events = "TextChanged,InsertEnter",
				})

				local ls = require("luasnip")
				vim.keymap.set({ "i", "s" }, "<M-n>", function()
					if ls.choice_active() then
						ls.change_choice(1)
					end
				end)

				-- LuaSnip Snippet History Fix (Seems to work really well, I think.)
				local luasnip_fix_augroup = vim.api.nvim_create_augroup("MyLuaSnipHistory", { clear = true })
				vim.api.nvim_create_autocmd("ModeChanged", {
					pattern = "*",
					callback = function()
						if
							(
								(vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
								or vim.v.event.old_mode == "i"
							)
							and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
							and not require("luasnip").session.jump_active
						then
							require("luasnip").unlink_current()
						end
					end,
					group = luasnip_fix_augroup,
				})
			end,
		},
		{
			"blink-cmp-supermaven",
			for_cat = "general.cmp",
			dep_of = { "blink.cmp" },
		},
		{
			"blink.cmp",
			for_cat = "general.cmp",
			-- cmd = { "" },
			event = { "DeferredUIEnter" },
			-- ft = "",
			-- keys = "",
			-- colorscheme = "",
			after = function(_)
				local lsp_utils = require("conf.lsp.utils")
				require("blink.cmp").setup({
					cmdline = {
						enabled = true,
						completion = {
							menu = { auto_show = true },
						},
					},
					keymap = {
						preset = "default",
						["<C-y>"] = {
							function(cmp)
								if cmp.is_menu_visible() then
									return cmp.select_and_accept()
								end
								return cmp.show()
							end,
						},
					},
					appearance = {
						-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
						nerd_font_variant = "normal",
					},
					signature = { enabled = true },
					-- snippets = {
					-- 	-- preset = "default",
					-- 	preset = "luasnip",
					-- },
					sources = {
						default = { "supermaven", "lsp", "path", "snippets", "buffer" },
						providers = {
							-- supermaven integration into blink
							supermaven = {
								name = "supermaven",
								module = "blink-cmp-supermaven",
								async = true,
								transform_items = function(_, items)
									for _, item in ipairs(items) do
										item.kind_icon = ""
										item.kind_name = "supermaven"
									end
									return items
								end,
							},
							-- Local buffer text completion
							buffer = {
								opts = {
									get_bufnrs = function()
										return vim.tbl_filter(function(bufnr)
											return vim.bo[bufnr].buftype == ""
										end, vim.api.nvim_list_bufs())
									end,
								},
							},
						},
					},
					fuzzy = { implementation = "prefer_rust_with_warning" },
					completion = {
						documentation = { auto_show = true },
						menu = {
							auto_show = true,
							draw = {
								-- columns = {
								-- 	{ "label", "label_description", gap = 1 },
								-- 	{ "kind_icon", "kind" },
								-- },
								columns = {
									{ "kind_icon" },
									{ "label", "label_description", gap = 1 },
									{ "source_name" },
								},
								components = {
									kind_icon = {
										text = function(ctx)
											if ctx.source_name == "supermaven" then
												return ""
											end
											if lsp_utils.attached_lsp_name() == "ocamllsp" then
												local kind_icon = require("plugins.completion.ocaml").cmp_kinds[ctx.kind]
												if kind_icon then
													return kind_icon
												end
											end
											local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
											return kind_icon
										end,
									},
									source_name = {
										text = function(ctx)
											local lsp_icon = require("conf.lsp.utils").attached_icon(0)
											local source_icon = ({
												buffer = "📖",
												LSP = lsp_icon,
												Snippets = "✂️",
												supermaven = "",
											})[ctx.source_name]
											return source_icon
										end,
									},
								},
							},
						},
						trigger = {
							show_on_trigger_character = true,
							show_on_blocked_trigger_characters = { " ", "\n", "\t" },
							prefetch_on_insert = true,
							show_on_accept_on_trigger_character = true,
							show_on_insert_on_trigger_character = true,
							show_on_x_blocked_trigger_characters = { "'", '"', "(" },
						},
					},
				})
			end,
		},
	}
end

for key, value in pairs(default) do
	plugins[key] = value
end

return plugins
