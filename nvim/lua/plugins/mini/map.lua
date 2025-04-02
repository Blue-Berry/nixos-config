require("mini.map").setup({
	integrations = nil,
})
local minimap_keymap = require("lzextras").keymap("mini.nvim")

minimap_keymap.set("n", "<Leader>um", function()
  require("mini.map").toggle()
end, { desc = "Toggle minimap" })
