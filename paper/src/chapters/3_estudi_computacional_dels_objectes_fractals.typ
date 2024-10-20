#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw

= Estudi computacional dels objectes fractals

Explicació de la part pràctica del projecte.

== Generació de fractals


=== Exemple senzill de fractal <cap-exemple-gen-fractal>
Com a demostració de la propietat d'autosimilitud, creem una fractal senzilla, que generarem de forma iterativa. Sigui $F_0$ la primera iteració de la nostra fractal. $F_0$ consistirà en un quadrat de costat $c$ a $RR^2$.

#let my_fractal(n) = {
  canvas({
      import draw: *

      
      
      line((0, 0), (5, 0), (5, -5), (0, -5), close: true)

      let p = (2.5, 0)

      for i in range(n) {
        line((2.5, 0), (2.5, -5))

        
      }

      
    })
}

#figure(caption: [Representació de $F_0$])[
  #grid(columns: 2, gutter: 2em)[
    #my_fractal(0)
  ][
    #my_fractal(1)
  ]
]

== Anàlisi algorísmic

Complexitat temporal dels algoritmes per generar cada fractal.

== Entorn de generació

Explicació de com aplicar els algoritmes. Amb quin llenguatge, en quin entorn. També mostrar la interfície del programa.
