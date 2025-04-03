return{
    "rainbow-delimiters.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function(_)
      require('rainbow-delimiters.setup').setup({})
    end,
}
