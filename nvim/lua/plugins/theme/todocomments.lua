return {
  'todo-comments.nvim',
  on_plugin = 'nvim-lspconfig',
  after = function(plugin)
    require('todo-comments').setup({
    })
  end,
}
