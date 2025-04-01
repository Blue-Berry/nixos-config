vim.lsp.enable({"ocamllsp"})
vim.lsp.start(vim.lsp.config.ocamllsp)
local set = vim.opt_local

set.shiftwidth = 2

vim.keymap.set("n", "<space>oc", "<cmd>MerlinConstruct<CR>", { buffer = 0, desc = "[O]caml [C]onstruct" })
