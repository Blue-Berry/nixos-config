
local toggle_spell = function()
  vim.wo.spell = not vim.wo.spell
  vim.cmd("redraw")
end


vim.keymap.set("n", "<leader>s", toggle_spell, { desc = "Spell Toggle" })
