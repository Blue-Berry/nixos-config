return
{
  "dropbar.nvim",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  after = function(plugin)
    require('dropbar').setup({})
  end,
}
