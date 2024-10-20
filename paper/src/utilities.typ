#import "../meta.typ": PRINT

#let numbered_eq = math.equation.with(
    block: true,
    numbering: n => {
      let h = counter(heading).get().first()
      [(#h.#n)]
    },
)

#let printablelink(text, src) = {
  if (PRINT) [
    #text <#src>
  ] else [
    #underline[#link(src, text)]
  ]
}

