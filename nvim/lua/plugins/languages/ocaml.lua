return {
	{
		"vim-ocaml",
		for_cat = "languages.ocaml",
		event = "DeferredUIEnter",
	},
	{
		"ctrlp.vim",
		ft = "ocaml",
		for_cat = "languages.ocaml",
	},
	{
		"ocaml",
		for_cat = "languages.ocaml",
		on_require = { "ocaml" },
		after = function(_)
			require("ocaml").setup({
				install_rapper = false,
				install_mlx = false,
				setup_lspconfig = false,
				setup_conform = false,
			})
		end,
	},
	{
		"alloc_scan",
		for_cat = "languages.ocaml",
		ft = "ocaml",
	},
}
