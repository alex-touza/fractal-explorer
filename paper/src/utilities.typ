#let numbered_eq = math.equation.with(
    block: true,
    numbering: n => {
      let h = counter(heading).get().first()
      [(#h.#n)]
    },
)
