return
-- {
-- 		"vim-sleuth",
-- 		for_cat = 'general.always',
-- 		event = "DeferredUIEnter",
-- }
{
  'guess-indent.nvim',
	for_cat = 'general.always',
	event = "DeferredUIEnter",
  after = function() require('guess-indent').setup {
			filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
				"bigfile",
			},
	} end,
}
