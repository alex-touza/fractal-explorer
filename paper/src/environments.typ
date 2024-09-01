#import "@preview/ctheorems:1.1.2": *



#let def = thmplain("def", "Definició", base_level: 1, titlefmt: strong)

#let proposition = thmplain("proposition", "Proposició", base_level: 1, titlefmt: strong)

#let theorem = thmplain("theorem", "Teorema", base_level: 1, titlefmt: strong)

#let property = thmplain("property", "Propietat", base_level: 1, titlefmt: strong)

#let explanation = thmplain("explanation", "Explicació", base_level: 1, namefmt: emph).with(numbering: none)

#let todo = thmbox(
  "todo",
  "TODO",
  fill: rgb("#ff222233"),
  base_level: 1,
)

#let demo = thmproof(
  "demo",
  "Demostració"
)

