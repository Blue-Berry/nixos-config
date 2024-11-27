return {
 {
    "catppuccin-nvim",
    for_cat = 'general.telescope',
    lazy = false,
    after = function(plugin)
      require("catppuccin").setup({
        compile_path = nixCats("cacheDir"),
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.teal },
            ["@module"] = { fg = colors.red },
            ["@keyword.conditional"] = { fg = colors.yellow },
            ["@keyword.repeat"] = { fg = colors.yellow },
            ["@keyword.type"] = { fg = colors.teal },
            ["@keyword.modifier"] = { fg = colors.teal },
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
