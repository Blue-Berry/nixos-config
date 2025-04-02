return {
  "nvim-bqf",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  -- keys = "",
  after = function(plugin)
    require('bqf').setup({})
  end,
}
