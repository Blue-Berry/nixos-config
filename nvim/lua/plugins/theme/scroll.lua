return {
  "neoscroll.nvim",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  -- keys = "",
  after = function(plugin)
    require('neoscroll').setup({})
  end,
}
