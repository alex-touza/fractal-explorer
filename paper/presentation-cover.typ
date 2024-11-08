#import "src/figures.typ"
#import "@preview/cetz:0.2.2": canvas, draw, plot

#set page(width: auto, height: auto, fill: rgb("#00000000"))

#rotate(14deg,
  figures.koch-snowflake(
    sides: 6, size: 5, n: 5,
    func: i => draw.set-style(stroke: blue.mix((purple, i / 2)).lighten(20%*i))
  )
)