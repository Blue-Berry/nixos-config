local set = vim.opt_local

set.shiftwidth = 2

local function search_by_type()
    require("ocaml.search_by_type")
    SEARCH_BY_TYPE()
end

vim.keymap.set("n", "<leader>cos", search_by_type, { desc = "[C]ode [O]caml [S]earch by type" })
