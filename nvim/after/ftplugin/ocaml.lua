require("conf.lsp.utils").enable_and_start("ocamllsp", "ocamllsp-fallback")
local set = vim.opt_local

set.shiftwidth = 2

vim.keymap.set("n", "<space>oc", "<cmd>MerlinConstruct<CR>", { buffer = 0, desc = "[O]caml [C]onstruct" })

vim.keymap.set("n", "<space>op", require("ocaml.mappings").dune_promote_file, { buffer = 0, desc = "Promote file" })
vim.keymap.set("n", "<space>od", require("ocaml.mappings").destruct, { buffer = 0, desc = "Deconstruct match" })
