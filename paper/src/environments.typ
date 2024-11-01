#import "lib/ctheorems.typ": *



#let def = thmplain("def", "Definició", base_level: 1, titlefmt: strong)

#let proposition = thmplain("def", "Proposició", base_level: 1, titlefmt: strong)

#let lemma = thmplain("def", "Lema", base_level: 1, titlefmt: strong)

#let theorem = thmplain("def", "Teorema", base_level: 1, titlefmt: strong)

//#let property = thmplain("property", "Propietat", base_level: 1, titlefmt: strong)

#let explanation = thmplain("explanation", "Explicació", base_level: 0, namefmt: it => [(#it)])

#let demo = thmproof(
  "demo",
  "Demostració",

)

