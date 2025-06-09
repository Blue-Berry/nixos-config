local M = {}
M.setup = function(colors)
	local _ = {
		_rosewater = colors.rosewater,
		_flamingo = colors.flamingo,
		_pink = colors.pink,
		_mauve = colors.mauve,
		_red = colors.red,
		_maroon = colors.maroon,
		_peach = colors.peach,
		_yellow = colors.yellow,
		_green = colors.green,
		_teal = colors.teal,
		_sky = colors.sky,
		_sapphire = colors.sapphire,
		_blue = colors.blue,
		_lavender = colors.lavender,
		_text = colors.text,
		_subtext1 = colors.subtext1,
		_subtext0 = colors.subtext0,
		_overlay2 = colors.overlay2,
		_overlay1 = colors.overlay1,
		_overlay0 = colors.overlay0,
		_surface2 = colors.surface2,
		_surface1 = colors.surface1,
		_surface0 = colors.surface0,
		_base = colors.base,
		_mantle = colors.mantle,
		_crust = colors.crust,
	}
	local tokens = {
		comments = { fg = colors.overlay2, style = { "italic" } },
		constants = { fg = colors.peach },
		escape_sequence = { fg = colors.pink },
		functions = { fg = colors.blue, style = { "italic" } },
		keywords = { fg = colors.mauve },
		module_signature = { fg = colors.yellow },
		modules = { fg = colors.lavender },
		parameters = { fg = colors.maroon },
		parantheses_delimiters = { fg = colors.overlay2 },
		strings = { fg = colors.green },
		symbols_atoms = { fg = colors.red },
		types = { fg = colors.teal },
		union_members = { fg = colors.teal },
	}
	return {
		-- @lsp.type.typeParameter.ocaml
		["@comment.ocaml"] = tokens.comments,
		["@constant.builtin.ocaml"] = tokens.constants,
		["@function.call.ocaml"] = tokens.functions,
		["@keyword.ocaml"] = tokens.keywords,
		["@label.ocaml"] = tokens.parameters,
		["@lsp.type.enumMember.ocaml"] = tokens.union_members,
		["@lsp.type.function.ocaml"] = tokens.functions,
		["@lsp.type.number.ocaml"] = tokens.constants,
		["@lsp.type.string.ocaml"] = tokens.strings,
		["@lsp.type.type.ocaml"] = tokens.types,
		["@type.builtin.ocaml"] = tokens.types,
		["@module.ocaml"] = tokens.modules,
		["@punctuation.bracket.ocaml"] = tokens.parantheses_delimiters,
		["@punctuation.delimiter.ocaml"] = tokens.parantheses_delimiters,
		["@string.escape.ocaml"] = tokens.escape_sequence,
		["@string.special.ocaml"] = tokens.symbols_atoms,
		["@variable.parameter.ocaml"] = tokens.parameters,
	}
end
return M

-- "rosewater"
-- "flamingo"
-- "pink"
-- "mauve"
-- "red"
-- "maroon"
-- "peach"
-- "yellow"
-- "green"
-- "teal"
-- "sky"
-- "sapphire"
-- "blue"
-- "lavender"
-- "text"
-- "subtext1"
-- "subtext0"
-- "overlay2"
-- "overlay1"
-- "overlay0"
-- "surface2"
-- "surface1"
-- "surface0"
-- "base"
-- "mantle"
-- "crust"
