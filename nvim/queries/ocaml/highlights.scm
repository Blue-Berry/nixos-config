; extends
; Source: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/ocaml/highlights.scm
; Modules
;--------
([
  (module_name)
  (module_type_name)
] @module (#set! priority 135))

((escape_sequence) @string.escape (#set! priority 135))

([
  (conversion_specification)
  (pretty_printing_indication)
] @string.special (#set! priority 135))


("fun" @keyword.function (#set! conceal "λ") (#set! priority 135))

((type_constructor) @type.builtin
  (#eq? @type.builtin
    "unit") (#set! priority 135) (#set! conceal "⊤"))

("*" @operator
   (#set! priority 135) (#set! conceal "×"))
