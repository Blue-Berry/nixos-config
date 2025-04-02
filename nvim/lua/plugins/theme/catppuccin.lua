return {
	{
		"catppuccin-nvim",
		for_cat = "general.telescope",
		lazy = false,
		after = function(_)
			require("catppuccin").setup({
				transparent_background = false, -- disables setting the background color.
				compile_path = nixCats("cacheDir"),
				custom_highlights = function(colors)
					return {
						LineNr = { fg = colors.blue },
						["@module"] = { fg = colors.red },
						["@keyword.conditional"] = { fg = colors.yellow },
						["@keyword.modifier"] = { fg = colors.teal },
						["@variable.parameter"] = { fg = colors.sapphire },
						["@variable.member"] = { fg = colors.mauve },
						["@keyword"] = { fg = colors.sky },
						["@keyword.coroutine"] = { fg = colors.sky },
						["@keyword.function"] = { fg = colors.sky },
						["@keyword.import"] = { fg = colors.sky },
						["@keyword.repeat"] = { fg = colors.sky },
						["@keyword.return"] = { fg = colors.sky },
						["@keyword.debug"] = { fg = colors.sky },
						["@comment.documentation"] = { fg = colors.overlay1, style = { "italic" } },

						-- @keyword.function
					}
				end,
				flavour = "mocha",
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					noice = true,
					notify = true,
					dap = true,
					fzf = true,
					flash = true,
					dap_ui = true,
					fidget = true,
					markdown = true,
					which_key = true,
					rainbow_delimiters = true,
					nvim_surround = true,
					indent_blankline = {
						enabled = false,
						-- scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
						colored_indent_levels = true,
					},
					dropbar = {
						enabled = true,
						color_mode = true, -- enable color for kind's texts, not just kind's icons
					},
				},
			})
		end,
	},
}
-- "rosewater"
-- "flamingo"
-- "pink"
-- "mauve"
-- "red"
-- "maroon"
-- "peach"
-- "yellow"
-- "green"
-- "teal"
-- "sky"
-- "sapphire"
-- "blue"
-- "lavender"
-- "text"
-- "subtext1"
-- "subtext0"
-- "overlay2"
-- "overlay1"
-- "overlay0"
-- "surface2"
-- "surface1"
-- "surface0"
-- "base"
-- "mantle"
-- "crust"
