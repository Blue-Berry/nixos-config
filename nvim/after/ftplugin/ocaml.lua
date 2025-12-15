require("conf.lsp.utils").enable_and_start_with_fallback("ocamllsp")
local set = vim.opt_local

set.shiftwidth = 2

require("ocaml").setup({
  keymaps = {
    jump_next_hole = "<leader>on",
    jump_prev_hole = "<leader>op",
    construct = "<leader>oc",
    jump = "<leader>oj",
    phrase_prev = "<leader>opp",
    phrase_next = "<leader>opn",
    infer = "<leader>oi",
    switch_ml_mli = "<leader>os",
    type_enclosing = "<leader>ot",
    type_enclosing_grow = "<Up>",
    type_enclosing_shrink = "<Down>",
    type_enclosing_increase = "<Right>",
    type_enclosing_decrease = "<Left>",
  },
})
