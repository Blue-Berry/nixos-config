; extends
; Source: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/ocaml/highlights.scm
; Modules
;--------
([
  (module_name)
  (module_type_name)]
 @module (#set! priority 135))

((escape_sequence) @string.escape (#set! priority 135))

([
  (conversion_specification)
  (pretty_printing_indication)]
 @string.special (#set! priority 135))


("fun" @keyword.function (#set! conceal "λ") (#set! priority 135))

((type_constructor) @type.builtin (#set! priority 135))


((type_constructor) @type.builtin
  (#eq? @type.builtin
    "unit") (#set! priority 135) (#set! conceal "⊤"))

((type_variable) @type_variable (#set! priority 134))

("*" @operator
   (#set! priority 135) (#set! conceal "×"))



("|]" @punctuation.bracket
   (#set! priority 135) (#set! conceal "〛"))

("[|" @punctuation.bracket
   (#set! priority 135) (#set! conceal "〚"))



((type_variable) @type_variable
  (#eq? @type_variable
    "'a") (#set! priority 135) (#set! conceal "α"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'b") (#set! priority 135) (#set! conceal "β"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'c") (#set! priority 135) (#set! conceal "γ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'d") (#set! priority 135) (#set! conceal "δ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'e") (#set! priority 135) (#set! conceal "ε"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'f") (#set! priority 135) (#set! conceal "φ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'i") (#set! priority 135) (#set! conceal "ι"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'k") (#set! priority 135) (#set! conceal "κ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'m") (#set! priority 135) (#set! conceal "μ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'n") (#set! priority 135) (#set! conceal "ν"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'o") (#set! priority 135) (#set! conceal "ω"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'p") (#set! priority 135) (#set! conceal "π"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'r") (#set! priority 135) (#set! conceal "ρ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'s") (#set! priority 135) (#set! conceal "σ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'t") (#set! priority 135) (#set! conceal "τ"))
((type_variable) @type_variable
  (#eq? @type_variable
    "'x") (#set! priority 135) (#set! conceal "ξ"))
