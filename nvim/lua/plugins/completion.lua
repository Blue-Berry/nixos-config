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

return {
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
						((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
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
		after = function(plugin)
			-- [[ Configure nvim-cmp ]]
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_kinds = {
				Class = "ﴯ",
				Color = "",
				Constant = "",
				Constructor = "ﬦ",
				Enum = "ﬦ",
				EnumMember = "",
				Event = "",
				Field = "ﬦ",
				File = "",
				Folder = "",
				Function = "ﬦ",
				Interface = "",
				Keyword = "",
				Method = "ﬦ",
				Module = "",
				Operator = "",
				Property = "ﬦ",
				Reference = "",
				Snippet = "﬌",
				Struct = "",
				Text = "",
				TypeParameter = "",
				Unit = "",
				Value = "ﬦ",
				Variable = "ﬦ",
				Supermaven = "",
			}

			cmp.setup({
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.kind = cmp_kinds[vim_item.kind]
						local lsp_icon = require("conf.lsp.utils").attached_icon(0)
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
	{
		"supermaven-nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		after = function(_)
			require("supermaven-nvim").setup({
				-- keymaps = {
				-- 	accept_suggestion = "<Tab>",
				-- 	clear_suggestion = "<C-]>",
				-- 	accept_word = "<C-j>",
				-- },
				ignore_filetypes = {bigfile = true},
				disable_inline_completion = false, -- disables inline completion for use with cmp
				disable_keymaps = true, -- disables built in keymaps for more manual control
			})
			vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", {fg ="#6CC644"})
		end,
	},
}
