local set = vim.opt_local

set.shiftwidth = 2

vim.keymap.set("n", "<space>cop", require("ocaml.mappings").dune_promote_file, { buffer = 0, desc = "Promote file" })
vim.keymap.set("n", "<space>cod", require("ocaml.mappings").destruct, { buffer = 0, desc = "Deconstruct match" })

local function search_by_type()
    require("ocaml.search_by_type")
    SEARCH_BY_TYPE()
end

vim.keymap.set("n", "<leader>cos", search_by_type, { desc = "[C]ode [O]caml [S]earch by type" })
