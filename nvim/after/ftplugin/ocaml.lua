local set = vim.opt_local

set.shiftwidth = 2

vim.keymap.set("n", "<space>cop", require("ocaml.mappings").dune_promote_file, { buffer = 0 })
vim.keymap.set("n", "<space>cod", require("ocaml.mappings").destruct, { buffer = 0 })
