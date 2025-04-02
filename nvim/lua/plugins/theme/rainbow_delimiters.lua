return{
    "rainbow-delimiters.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function(plugin)
      require('rainbow-delimiters.setup').setup({})
    end,
}
