local set = vim.opt_local

set.shiftwidth = 2

local function search_by_type()
    require("ocaml.search_by_type")
    SEARCH_BY_TYPE()
end

vim.keymap.set("n", "<leader>os", search_by_type, { desc = "[O]caml [S]earch by type" })
vim.keymap.set("n", "<space>oc", "<cmd>MerlinConstruct<CR>", { buffer = 0, desc = "[O]caml [C]onstruct" })
