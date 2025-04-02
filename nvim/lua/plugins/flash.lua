return {
{
    "flash.nvim",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    keys = {
      { "<leader>s", function() require("flash").jump() end, mode = { "n", "x", "o" },                            desc = "Flash" },
      { "R",         mode = { "o", "x" },                    function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
    after = function(plugin)
      require('flash').setup({
        modes = {
          char = {
            enabled = false
          },
          search = {
            enabled = false
          }
        }
      })
    end,
  },

}
