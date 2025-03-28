
local merlinPath = nixCats('merlinPath').."/share/merlin/vim"
vim.api.nvim_command(string.format('execute "set rtp+=%s"', merlinPath))

local dest_dir = "/tmp/merlin/vim/doc"
vim.fn.mkdir(dest_dir, 'p')
local dest_path = dest_dir .. '/' .. "merlin.txt"
local source_path = merlinPath .. '/doc/merlin.txt'
vim.fn.system { 'cp', source_path, dest_path }
vim.api.nvim_command(string.format('execute "helptags %s"', dest_dir))
