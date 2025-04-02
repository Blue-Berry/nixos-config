return {
  "mini.nvim",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  dep_of = { "markdown.nvim" },
  on_plugin = { "nvim-treesitter" },
  after = function()
    -- use gcc for toggle comment
    require("mini.comment").setup()
    -- use <alt-h,j,k,l> for moving selected text
    require("mini.move").setup()
    -- autopairs
    require("mini.pairs").setup()
    -- extend f, F, t, T to multiple lines
    require("mini.jump").setup()
    -- add animations to vim actions
    require('mini.animate').setup()
    -- highlight words under cursor
    require("mini.cursorword").setup()
  end,
}
