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
					local base_styles = {
						LineNr = { fg = colors.blue },
						-- ["@module"] = { fg = colors.red },
						-- ["@keyword.conditional"] = { fg = colors.yellow },
						-- ["@keyword.modifier"] = { fg = colors.teal },
						-- ["@variable.parameter"] = { fg = colors.sapphire },
						-- ["@variable.member"] = { fg = colors.mauve },
						-- ["@keyword"] = { fg = colors.sky },
						-- ["@keyword.coroutine"] = { fg = colors.sky },
						-- ["@keyword.function"] = { fg = colors.sky },
						-- ["@keyword.import"] = { fg = colors.sky },
						-- ["@keyword.repeat"] = { fg = colors.sky },
						-- ["@keyword.return"] = { fg = colors.sky },
						-- ["@keyword.debug"] = { fg = colors.sky },
						-- ["@comment.documentation"] = { fg = colors.overlay1, style = { "italic" } },
						-- @keyword.function
					}
					local extra_styles = {
						require("plugins.theme.colorscheme.ocaml").setup(colors),
					}
					for _, style in pairs(extra_styles) do
						for key, value in pairs(style) do
							base_styles[key] = value
						end
					end
					return base_styles
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
						enabled = true,
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

-- For list of highlights
-- :telescope highlights
-- For inspecting highihg under cursor
-- :Inspect

-- Styles list
-- :h highlight-args

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
