#import "../meta.typ": PRINT

#let numbered_eq = math.equation.with(
    block: true,
    numbering: n => {
      let h = counter(heading).get().first()
      [(#h.#n)]
    },
)

#let printable-hyperlink(text, src) = {
  if (PRINT) [#text <#link(src)>] else [#underline[#link(src, text)]]
}

#let pritable-doclink(label) = {
  let pageref(label) = context {
    let loc = locate(label)
    let nums = counter(page).at(loc)
    link(loc, numbering(loc.page-numbering(), ..nums))

  }

  ref(label)

  if (PRINT) [, pàg. #pageref(label)]
}

#let pageref(label) = context {
  let loc = locate(label)
  let nums = counter(page).at(loc)
  link(loc, numbering(loc.page-numbering(), ..nums))
}