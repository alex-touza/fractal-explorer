#import "utilities.typ": *
#import "shortcuts.typ": *
#import "geo.typ": *
#import "@preview/cetz:0.2.2": canvas, draw, plot

#let cuboids(a, b, h) = {
  let _line = draw.line.with(stroke: (dash: "dashed"))
  

  let persp = (0.9*b, 0.4*b)

  let A = (a, 0)
  let B = (a, h)
  let C = (0, h)
  let D = (0, 0)

  let Ap = sum-vec(A, persp)
  let Bp = sum-vec(B, persp)
  let Cp = sum-vec(C, persp)
  let Dp = sum-vec(D, persp)
      
  let cuboide() = {
    import draw: *
    // Quadrat del davant
    line(A, B)
    line(B, C)
    line(C, D)
    line(D, A)

    // Costats laterals
    line(A, Ap)
    line(B, Bp)
    line(C, Cp)
    _line(D, Dp)

    // Quadrat del darrere
    line(Bp, Ap)
    line(Cp, Bp)
    _line(Cp, Dp)
    _line(Dp, Ap)
  }
  
  grid(columns: 2, gutter: 15pt,
    canvas({
      cuboide()
    }),
    canvas({
      import draw: *

      

      let _line = draw.line.with(stroke: (dash: "dashed", paint: black.lighten(20%)))

      let center = fact-vec(Bp, 1/2)

      let front = fact-vec((a, h), 1/2)
      let left = fact-vec(Cp, 1/2)
      

      _line(front, sum-vec(front, persp))
      _line(left, sum-vec(left, A))

      //circle(center, radius: 0.05, fill: black)

      
      

      // Quadrat de l'esquerra
      _line(fact-vec(C, 1/2), sum-vec(fact-vec(C, 1/2), persp))
      _line(sum-vec(D, fact-vec(persp, 1/2)), sum-vec(C, fact-vec(persp, 1/2)))

      

      // Quadrat de la dreta
      _line((a, h/2), sum-vec((a, h/2), persp))
      _line(sum-vec(A, fact-vec(persp, 1/2)), sum-vec(B, fact-vec(persp, 1/2)))

      // Quadrat de dalt
      line((a/2, h), sum-vec((a/2, h), persp))
      line(sum-vec(C, fact-vec(persp, 1/2)), sum-vec(B, fact-vec(persp, 1/2)))


      // Quadrat de baix
      _line((a/2, 0), sum-vec((a/2, 0), persp))
      _line(sum-vec(D, fact-vec(persp, 1/2)), sum-vec(A, fact-vec(persp, 1/2)))

      _line(sum-vec((a/2, 0), fact-vec(persp, 1/2)), sum-vec((a/2, h), fact-vec(persp, 1/2)) )

      let _line = draw.line.with(stroke: (dash: "dashed", paint: black.lighten(40%)))

      // Quadrat del davant
      
      line(fact-vec(A, 1/2), (a/2, h))
      line(fact-vec(C, 1/2), (a, h/2))

      // Quadrat del fons
      _line(sum-vec(fact-vec(A, 1/2), persp), sum-vec((a/2, h), persp))
      _line(sum-vec(fact-vec(C, 1/2), persp), sum-vec((a, h/2), persp))

      cuboide()

    })
  )
}

#let cantor(n) = {
  canvas({
    import draw: *

    let start = (0, 10)

    let sym_pos = -1;

    /*
    Eliminar el terç del mig del parell a.
    El paràmetre i és només per saber quantes iteracions queden.
    */
    let rec(i, a, y) = {
      let b = (a.first(), a.first() + (a.last() - a.first())*(1/3))
      let c = (a.first() + (a.last() - a.first())*(2/3), a.last())
      
      i -= 1
      
      if (i == 0) {
        line((b.first(), y), (b.last(), y))
        line((c.first(), y), (c.last(), y))
        
      } else {
        rec(i, b, y)
        rec(i, c, y)
      }
    }

    line((start.first(), 0), (start.last(), 0))
    content((sym_pos, 0), [$C_0$])
    
    for i in range(1, n) {
      rec(i, start, -i*0.8)

      /*
      Dibuixem línies entre cada parella de punts, alternant.
      
      for (j, p) in c.slice(0, -1).enumerate() {

        // Hem de deixar espais en blanc.
        if (calc.rem(j, 2) == 1) {continue}
        
        line((p, -i), (c.at(j+1), -i ))
      }
      */ 

      content((sym_pos, -i*0.8), [$C_#i$])
    }
  })
}

#let sierpinski(n) = {
  canvas({
    import draw: *

    let c = 4
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

    for i in range(n) {
      let x = calc.rem(i, 3)*5
      let y = - calc.floor(i / 3)*4
      
      rec(((0 + x, 0 + y), (c/2 + x, h + y), (c + x, 0 + y)), i)


      content((x + 2, y - 0.4), [$S_#i$])
    }
    
  })
}

#let koch-rec(seg, i, index, number: false) = {
    import draw: *
    let a = seg.first()
    let b = seg.last()
    let v = p-to-vec(a, b)
    let ang = calc.atan2(v.first(), v.last())
    
    let center = sum-vec(a, fact-vec(v, 1/2))
    
    let side = fact-vec(v, 1/3)

    let p = sum-vec(a, fact-vec(v, 1/3))
    let q = sum-vec(a, fact-vec(v, 2/3))

    let t = sum-vec(p, (
      magnitude(side) * calc.cos(60deg + ang),
      magnitude(side) * calc.sin(60deg + ang)
    ))

    // Punta nova
    //let p = p-to-vec(center, h)
    
    i -= 1
    
    if i == 0 {
      if number {
        let middle = average(..seg)
        content((middle.first(), middle.last() + 0.5), [$#index$])
      }
      
      line(..seg, fill: black)
    } else {
      
      koch-rec(
        (a, p), i, 1
      )
      koch-rec(
        (p, t), i, 2
      )
      koch-rec(
        (t, q), i, 3
      )
      koch-rec(
        (q, b), i, 4
      )
      

    }
  }

#let koch(n, only-one: false, size: 12, number: false, from: 1) = {
  canvas({
    import draw: *

    // (0.4444444444444444, 0.0), (2.0, 1.1547005383792515),

    /*
    seg és una 2-tupla de parelles que representa
    el segment en què s'ha de dibuixar.
    */

    let fact = size * 2/5

    for i in (if only-one {range(n, n+1)} else {range(from, n+1)}) {
      koch-rec(((0, -i*fact), (size, -i*fact)), i, 1, number: number)

      content((-1, -i*fact), [$K_#(i - 1)$])
    }
    
  })
}

#let koch-snowflake(func: i => draw.set-style(stroke: blue.lighten(18%*i)), size: 10, sides: 5, n: 5) = {
  //let base_points = ((0, 0), (-1.55, 4.76), (2.5, 7.69), (6.55, 4.76), (5, 0))
  canvas({
    let i = 0
    for f in (0.2, 0.4, 0.7, 1.2) {
      i += 1
      func(i)
      let points = reg_polygon(sides, f*size)
      
      for i in range(points.len()) {
        
        
        koch-rec((points.at(i), points.at(calc.rem(i+1, points.len()))), n, 1)
      }
    
    }
  })
    
}