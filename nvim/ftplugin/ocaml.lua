vim.keymap.set("n", "<space>oc", "<cmd>MerlinConstruct<CR>", { buffer = 0, desc = "[O]caml [C]onstruct" })

vim.keymap.set("n", "<space>op", require("ocaml.mappings").dune_promote_file, { buffer = 0, desc = "Promote file" })
vim.keymap.set("n", "<space>od", require("ocaml.mappings").destruct, { buffer = 0, desc = "Deconstruct match" })

vim.o.conceallevel = 1
vim.o.concealcursor = "n"

local function search_by_type()
	require("ocaml.search_by_type")
	SEARCH_BY_TYPE()
end

vim.keymap.set("n", "<leader>os", search_by_type, { desc = "[O]caml [S]earch by type" })
