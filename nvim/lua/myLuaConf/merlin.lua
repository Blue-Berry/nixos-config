
local merlinPath = nixCats('merlinPath').."/share/merlin/vim"
vim.api.nvim_command(string.format('execute "set rtp+=%s"', merlinPath))
-- vim.api.nvim_command(string.format('helptags %s/share/merlin/vim/doc', merlinPath))
