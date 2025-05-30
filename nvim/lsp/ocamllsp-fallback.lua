return {
	cmd = { "ocamllsp-fallback" },
	filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
	root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
	settings = {
		codelens = { enable = true },
		inlayHints = { hintPatternVariables = true, hintLetBindings = true },
		extendedHover = { enable = true },
		syntaxDocumentation = { enable = true },
		merlinJumpCodeActions = { enable = true },
	},
}
