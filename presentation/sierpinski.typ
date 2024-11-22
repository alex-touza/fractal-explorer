#import "@preview/cetz:0.2.2": canvas, draw, plot

#let h-tri-eq(c) = {
  return calc.sqrt(2) * c / 2
}

#let average(a, b) = {
  return ((a.first() + b.first()) / 2,  (a.last() + b.last()) / 2,)
}

#let sierpinski(n, start: 1) = {
  canvas({
    import draw: *

    let c = 6
    let h = h-tri-eq(c)

    /*
    tri és una 3-tupla de parelles amb els tres punts entre els quals
    s'ha d'iterar.
    */
    let rec(tri, i) = {
      let a = tri.first()
      let b = tri.at(1)
      let c = tri.last()
      
      if i == 0 {
        line(a, b, c, fill: black)
      } else {
        i -= 1

        let left = average(a, b)
        let down = average(a, c)
        let right = average(b, c)

        rec((a, left, down), i)
        rec((left, b, right), i)
        rec((down, right, c), i)
      }
    }

    for i in range(start, n) {
      let x = calc.rem((i - start), 3)*8
      let y = - calc.floor((i - start) / 3)*4
      
      rec(((0 + x, 0 + y), (c/2 + x, h + y), (c + x, 0 + y)), i)


      //content((x + 3, y - 0.6), [$S_#i$])
    }
    
  })
}