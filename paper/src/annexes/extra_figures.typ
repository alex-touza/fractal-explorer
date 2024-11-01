#import "../../meta.typ": *
#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "../figures.typ"
#import "@preview/cetz:0.2.2": canvas, draw, plot

== Figures addicionals

#figure(caption: [Gràfica de la funció de Riemann.])[
  #canvas({
    import draw: *
  
    let Rie(n) = {
      return x => (range(1, n + 1).map(i => (calc.sin(i * i * x) / (n*n))).sum() )
    }

    if PLOTS {
      plot.plot(size: (10,8), axis-style: "school-book", plot-style: (stroke: blue.transparentize(50%)), y-label: "R(x)", {
        plot.add(domain: (-0.8, 0.8), samples: 250, axes: ("x", "y"), Rie(15))
      })
    } else {
      content((0, 0), text(red)[Gràfiques desactivades])
    }
    
  })
] <fig-grafica-riemann>

#figure(caption: [Gràfica de la funció de Weierstrass.])[
  #canvas({
    import draw: *
    
    let a = 0.5
    let b = 12
  
    let We(n) = {
      return x => (range(1, n + 1).map(i => (calc.pow(a, i)) * calc.cos(calc.pow(b, i) * x * calc.pi)).sum() )
    }
  
    if PLOTS {
      plot.plot(size: (10,8), axis-style: "school-book", plot-style: (stroke: blue.transparentize(50%)), y-label: "W(x)", {
        plot.add(domain: (-0.8, 0.8), samples: 250, axes: ("x", "y"), We(15))
      })
    } else {
       content((0, 0), text(red)[Gràfiques desactivades])
    }
    
  })
] <fig-grafica-weierstrass>

#figure(caption: [Primeres sis iteracions de la corba de Koch (#pritable-doclink(<cap-corba-koch>)).])[
  #figures.koch(6)
] <fig-koch-iteracions>
