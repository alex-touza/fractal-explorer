#import "../meta.typ": PRINT

#let colon = $#h(0%):$

#let arr = math.arrow

#let hausdorffdelta = $cal(H)_delta^s (A)$
#let hausdorff = $cal(H)^s (A)$


#let comment(c) = {
  set text(black.lighten(20%))
  $slash slash med$
  c
}