--  various, non-plugin config
require('conf.opts_and_keys')

--  register the extra lze handlers because we want to use them.
--  also add another one that makes enabling a spec for a category nicer
require("lze").register_handlers(require('nixCatsUtils.lzUtils').for_cat)

require('lze').register_handlers(require('lzextras').lsp)
--general plugins
require("plugins.init")
require("conf.colorscheme")


-- require("conf.LSPs")
require('conf.lsp.init')

--  we even ask nixCats if we included our debug stuff in this setup! (we didnt)
-- But we have a good base setup here as an example anyway!
if nixCats('debug') then
  require('conf.debug.init')
end
--  we included these though! Or, at least, the category is enabled.
-- these contain nvim-lint and conform setups.
if nixCats('format') then
  require('conf.format')
end
--  I didnt actually include any linters or formatters in this configuration,
-- but it is enough to serve as an example.
if nixCats('neovide') then
  require('conf.neovide')
end

require("conf.merlin")
