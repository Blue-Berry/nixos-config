local M = {}
M.setup = function(colors)
	return {
		["@lsp.type.function.ocaml"] = { fg = colors.red, style = { "italic" } },
	}
end

return M
