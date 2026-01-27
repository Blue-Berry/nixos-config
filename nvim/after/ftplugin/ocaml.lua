require("conf.lsp.utils").enable_and_start_with_fallback("ocamllsp")
local set = vim.opt_local

set.shiftwidth = 2

-- do
-- 	local function patch(obj, name, before, after)
-- 		local original = obj[name]
-- 		obj[name] = function(...)
-- 			local is_matched = before(...)
-- 			local values = { original(...) }
-- 			after(is_matched, ...)
-- 			return unpack(values)
-- 		end
-- 	end
-- 	patch(vim.api, "nvim_buf_set_extmark", function(bufnr, _, line, _, opts)
-- 		local chunks = opts.virt_text
-- 		if chunks and chunks[1] and chunks[1][2] == "LspCodeLens" then
-- 			local text = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1] or ""
-- 			local indent = text:match("^%s*") or ""
--
-- 			local indented = {}
-- 			for _, chunk in ipairs(chunks) do
-- 				indented[#indented + 1] = { indent .. chunk[1], chunk[2] }
-- 			end
--
-- 			opts.virt_text = nil
-- 			opts.virt_lines = { indented }
-- 			opts.virt_lines_above = true
-- 			return true
-- 		end
-- 		return false
-- 	end, function(is_matched)
-- 		if is_matched then
-- 			vim.fn.winrestview({ topfill = 1 })
-- 		end
-- 	end)
-- end
