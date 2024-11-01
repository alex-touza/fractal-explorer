#import "../utilities.typ": *

== Fragments de codi

=== Memòria

Aquí es presenten alguns fragments de codi rellevants d'aquesta mateixa memòria. El codi, que és en Typst, utilitza la llibreria #printable-hyperlink([`cetz`], "https://github.com/cetz-package/cetz") i el seu mòdul `draw`.

No es mostra tot el codi utilitzat; recordeu que el codi complet està disponible a a #printable-hyperlink("GitHub", "https://github.com/alex-touza/fractal-explorer").

==== Funcions de geometria

Per simplificar el codi, he escrit una petita llibreria amb algunes operacions bàsiques de vectors i punts.

```typc

// Parella de punts a vector
#let p-to-vec(a, b) = {
  return (b.first() - a.first(), b.last() - a.last())
}

// Suma dels vectors a i b
#let sum-vec(a, b) = {
  return (a.first() + b.first(), a.last() + b.last())
}

// Multiplicació del vector a per un real k
#let fact-vec(a, k) = {
  return (a.first()*k, a.last()*k)
}

// Component horitzontal del vector a
#let x-vec(a) = {
  return (a.first(), 0)
}

// Component vertical del vector a
#let y-vec(a) = {
  return (0, a.last())
}

// Altura per a un triangle equilàter de costat c 
#let h-tri-eq(c) = {
  return calc.sqrt(2) * c / 2
}

// Punt mig entre dos punts
#let average(a, b) = {
  return ((a.first() + b.first()) / 2,  (a.last() + b.last()) / 2,)
}

// Magnitude del vector v
#let magnitude(v) = {
  return calc.sqrt(v.first() * v.first() + v.last() * v.last())
}

// Pendent del vector v
#let slope(v) = {
  return v.last() / v.first()
}
```
==== Conjunt de Cantor

```typc

#let cantor(n) = {
  canvas({
    import draw: *

    let start = (0, 10)

    let sym_pos = -1;

    /*
    Eliminar el terç del mig del parell a.
    El paràmetre i és només per saber quantes iteracions queden.
    */
    let rec(i, a) = {
      let b = (a.first(), a.first() + (a.last() - a.first())*(1/3))
      let c = (a.first() + (a.last() - a.first())*(2/3), a.last())
      
      i -= 1
      
      if (i == 0) {
        //line(..b)
        
      } else {return (..rec(i, b), ..rec(i, c))}
    }

    line((start.first(), 0), (start.last(), 0))
    content((sym_pos, 0), [$C_0$])
    
    for i in range(1, n) {
      let c = rec(i, start)

      /*
      Dibuixem línies entre cada parella de punts, alternant.
      
      for (j, p) in c.slice(0, -1).enumerate() {

        // Hem de deixar espais en blanc.
        if (calc.rem(j, 2) == 1) {continue}
        
        line((p, -i), (c.at(j+1), -i ))
      }
      */ 

      content((sym_pos, -i), [$C_#i$])
    }
  })
}
``` <codi-cantor>

==== Triangle de Sierpinski

```typc
#let sierpinski(n) = {
  canvas({
    import draw: *

    let c = 4
    let h = h-tri-eq(c) 

    /*
    tri és una 3-tupla de parelles amb els tres punts entre els quals
    s'ha d'iterar.
    */
    let sierp(tri, i) = {
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

        sierp((a, left, down), i)
        sierp((left, b, right), i)
        sierp((down, right, c), i)
      }
    }

    for i in range(n) {
      let x = calc.rem(i, 3)
      let y = calc.floor(i / 3)
      
      sierp(((0 + x*5, 0 - y*4), (c/2 + x*5, h - y*4), (c + x*5, 0 - y*4)), i)
    }
    
  })
}

```

==== Corba de Koch

```typc
#let koch(n) = {
  canvas({
    import draw: *

    /*
    seg és una 2-tupla de parelles que representa
    el segment en què s'ha de dibuixar.
    */
    let rec(seg, i) = {
      let a = seg.first()
      let b = seg.last()
      let v = p-to-vec(a, b)
      let ang = calc.atan2(v.first(), v.last())
      
      
      let side = fact-vec(v, 1/3)

      let p = sum-vec(a, fact-vec(v, 1/3))
      let q = sum-vec(a, fact-vec(v, 2/3))

      let t = sum-vec(p, (
        magnitude(side) * calc.cos(60deg + ang),
        magnitude(side) * calc.sin(60deg + ang)
      ))
      
      i -= 1
      
      if i == 0 {
        line(..seg, fill: black)
      } else {
        
        rec(
          (a, p), i
        )
        rec(
          (p, t), i
        )
        rec(
          (t, q), i
        )
        rec(
          (q, b), i
        )
        

      }
    }

    for i in range(1, n+1) {
      rec(((0, -i*4), (12, -i*4)), i)
    }
    
  })
}
```