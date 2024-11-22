#import "@preview/touying:0.5.3": *
#import "theme.typ"
#import "sierpinski.typ": sierpinski
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#import "@preview/ctheorems:1.1.2": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/cetz:0.2.2": canvas, draw, plot
#import "@preview/lovelace:0.3.0": *

/*
Mostrar iteracions del triangle de Sierpinski

Mostrar costa per comparar-la amb la corba de koch --> Ser més didàctic, mostrar les fractals a la natura abans.

Les matemàtiques tracten d'explicar el món millor. La geometria fractal és una passa en aquesta direcció.

Simplificar menció de la dimensió de Hausdorff

Enllaçar dimensió topològica

Explicar el significat de la dimensió fractal fraccionària
*/

#let footnote = it => place(bottom + left, text(12pt, it))


#let cetz-canvas = touying-reducer.with(reduce: canvas, cover: draw.hide.with(bounds: true))

#set document(author: "Àlex Touza Luque", title: "Presentació del Treball de Recerca \"Estudi matemàtic i computacional de la geometria fractal\"")

#set text(lang: "ca")

#set heading(numbering: numbly("{1}.", default: "1.1"))

#show: theme.theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [*Estudi matemàtic i computacional dels objectes fractals*],
    subtitle: [Un aprofundiment en geometria, topologia i dimensió],
    author: [*Àlex Xavier Touza Luque*],
    date: [13 de novembre de 2024],
    institution: [Institut Ernest Lluch - Departament de Matemàtiques],
  ),
  config-common(slide-level: 2)
)

#let card = color => box.with(
      stroke: color,
      fill: color.transparentize(95%),
      width: 1fr,
      radius: 0.5em,
      inset: 0.75em
    )

#set heading(numbering: "1.")


#theme.title-slide()

/*
 
== Continguts <touying:hidden>

#list(marker: [--], tight: false)[
  Motivació i objectius
][
  L'estudi matemàtic
][
  L'estudi computacional
][
  Conclusions
]
*/
= Motivació i objectius

== Motivació

#align(center)[
  
  #image("mandelbrot_set_2.png", width: 600pt)

]

//*Matemàtiques* i *informàtica*


Aplicar *matemàtiques avançades* i *programació* en un sol treball



== Objectius del treball



Estudiar amb rigorositat la base matemàtica de les *fractals* $-->$ *Topologia*

#pause

*Demostracions* -- *Formalitat matemàtica*

#pause

*Programes informàtics* per generar-ne


= La geometria fractal

== Definició de fractal


#align(center)[
  #text(28pt)[_Què és una *fractal*?_]

  #pause

  *No* hi ha una *definició concreta*

  #pause

  S'hi associen diverses *característiques*

  //#pause

  //A la natura, es troben objectes amb *comportament fractal*
]




== Característiques de les fractals

#theme.slide(self => [

  
  #card(self.colors.primary)()[
    *Estructura detallada infinita*

    Les fractals no acaben sent llises, sinó que en ampliar-les apareixen més detalls.

    #pause
    
    #grid(columns: (1fr, 1fr), align: center)[
      #image("koch_one.png")

      
      _Corba de Koch_

      #pause
    ][
      #image("britain_full.gif", height: 210pt)

      _Costa de Gran Bretanya_
    ]
    
  ]

  #footnote[
    Imatges costa: ALG108 - CC BY-SA 4.0
  ]
])

#theme.slide(self => [
  #card(self.colors.primary)()[
    #set image(height: 210pt)
    *Mesura i estudi difícil*

    Mesures convencionals de llargada  donen resultats sense sentit. /* En corbes fractals, la llargada creix sense límit */

    #pause

    #grid(columns: (1fr, 1fr, 1fr), align: center)[
      #image("britain_big.gif")
    ][
      #image("britain_mid.gif")
    ][
      #image("britain_small.gif")
    ]

    #pause

    #set text(22pt)

    $
    lim_(epsilon -> 0) L_"total" (epsilon) = +infinity
    $
    
    
  ]
])

#theme.slide(self => [
  #card(self.colors.primary)()[
    *Definició recursiva*

    Per construir una fractal, pot ser necessari repetir un procés que depèn de si mateix.

    #pause

    #align(center, [
      #sierpinski(4)
      
      _Triangle de Sierpinski_
    ])
  ]

  #pause
  
  #card(self.colors.primary)()[
    *Auto-similitud*

    En una fractal, podem trobar còpies de si mateixa, exactes o quasi-exactes.
  ]

])

#theme.slide(self => [
  #card(self.colors.primary)()[
    *Definició simple*

    Les fractals es defineixen i construeixen de forma molt senzilla.

    #pause

    Són senzilles de generar amb un ordinador, però el seu estudi és molt difícil.

    #pause

    #align(center)[
      #image("mandelbrot_first.png", width: 250pt)
  
      _Conjunt de Mandelbrot (1979)_
    ]

    
    #footnote[Imatge: Robert Brooks, J. Peter Matelski]
  ]

  

 
  

  

])

== Fractals a la natura

A la natura, objectes amb *comportament fractal*

#pause

#grid(columns: (1fr, 1fr, 1fr), align: center, gutter: 1em)[
    #image("romanesco (loangogo).png", height: 180pt)
  ][
    #image("cristall congelat (Schnobby).png", height: 180pt)
  ][
    #image("floc de neu.png", height: 180pt)
  ][
    _Romanesco_
  ][
     _Cristall congelat_ /* Espècie de col que presenta autosimilitud*/
  ][
    _Floc de neu_
  ]



#pause

La *geometria fractal* és una forma *diferent i exacta* de veure la realitat

/* Descriure objectes reals amb la geometria clàssica és molt difícil */



#place(bottom + left, text(12pt)[Primera imatge: Ioangogo - CC BY-SA 4.0.
Segona imatge: Domini públic])


#{
  set heading(numbering: none)
  [
    ---
    ==
  ]
  
  text(28pt)[_Com expliquen les matemàtiques els objectes fractals?_]
}




= L'estudi matemàtic


---
#align(center, [
  Definició antiga de _fractal_:
  
  #text(25pt)[
    _Una *fractal* és un conjunt la *dimensió de Hausdorff* del qual supera la *dimensió topològica*_
  ]
])

== Literatura matemàtica

#grid(columns: (1fr, 1fr), align: center + bottom)[
  #image("edgar.png", height: 300pt)

  _Measure, Topology and Fractal Geometry_, *Gerald Edgar*
][
  #image("mandelbrot_book.png", width: 200pt)

  _The Fractal Geometry of Nature_, *Benoît Mandelbrot*
]




== Dimensió topològica

#theme.slide(self => [

  Informalment, la dimensió es defineix com el *nombre d'eixos de coordenades*

  #pause

  #align(center, cetz-canvas({
    import draw: *
    
    circle((0, 0), radius: 0.1, fill: black)
    content((0, -4))[*Dimensió 0*]

    (pause,)

    line((3, 0), (9, 0))

    content((6, -4), align(center)[
      *Dimensió 1* #linebreak()
      Longitud
    ])

    (pause,)

    line((12, -2), (18, -2), (18, 2), (12, 2), close: true, fill: black.lighten(60%) )

    content((15, -4), align(center)[
      *Dimensió 2* #linebreak()
      Àrea
    ])

  }))

  #pause


  És una *propietat intrínseca*, no depèn de l'entorn en què estigui inserit

  #pause

  Definició rigorosa $-->$ *Dimensió topològica*

  #pause
  
  *Dimensió paramètrica* / *Dimensió de recobriment de Lebesgue*

])
/*
#theme.slide(self => [

  S'han estudiat dues definicions diferents de dimensió:
  
  #grid(
    columns: (1fr, 1.2fr),
    gutter: 2em
  )[
    #card(self.colors.primary)()[
      *Dimensió paramètrica*

      Es basa en el nombre de paràmetres necessaris per obtenir tots els punts de l'objecte.

      $
      r#h(0%): arrow(x) = arrow(p) + lambda arrow(u) \
      pi#h(0%): arrow(x) = arrow(p) + lambda arrow(u) + mu arrow(v) \
      $
    ]
    #pause
  ][
    #card(self.colors.primary)()[
      *Dimensió de recobriment de Lebesgue*
  
      Definició topològica més rigorosa, basada en recobriments i refinaments.
  
      #align(center, canvas({
        import draw: *
    
        line((0,1), (4, 1), (2, 4), close: true, fill: gray.lighten(80%))
    
        bezier-through((5,1), (7, 3), (10, 2), )
    
        let draw-set(..pts, color)= catmull(..pts, close: true, stroke: color, fill: color.transparentize(70%))
    
        draw-set((1, 3), (-0.2, 1), (2, 1), green)
        draw-set((3, 3), (2, 1), (4.2, 1), red)
        draw-set((2, 4.2), (3, 2), (2, 1.25), (1, 2), purple)
    
        draw-set((5, 0.5), (5, 3), (8, 3), green)
        draw-set((10, 1.8), (10, 3), (8, 3), purple)
    
        //circle((1.25, 2.85), radius: 0.1, fill: blue.transparentize(40%), stroke: none)
        //circle((2.8, 2.85), radius: 0.1, fill: blue.transparentize(40%), stroke: none)
        circle((2, 1.3), radius: 0.1, fill: blue.transparentize(40%), stroke: none)
        circle((8, 3), radius: 0.1, fill: blue.transparentize(40%), stroke: none)
        
        })
      )
    
    ]
  ]

  //Anomenem aquesta noció s'anomena _dimensió topològica_ perquè no varia amb *homeomorfismes*.



])
*/

En objectes fractals, la *dimensió topològica* resulta ser ben estranya

#pause

#image("cantor.png")

#pause

_Dimensió 0? Dimensió 1?_ #pause Dimensió 0.

#pause

La dimensió no es correspon amb les *propietats* de l'objecte

== Dimensió fractal

#let hausdorffdelta = $cal(H)_delta^s (A)$
#let hausdorff = $cal(H)^s (A)$

/*
#theme.slide(self => {
  grid(columns: 2, gutter: 2em)[
    #card(self.colors.primary)()[
      *Mesura de Hausdorff*

      És una definició de llargada generalitzada per a objectes inserits en un entorn de dimensió superior.

      #pause

      #align(center,
      canvas(length: 7%, {
        import draw: *
    
        bezier((0, 1), (2, 3), (5, 1))
        bezier((5, 1), (7, 3), (10, 1))
    
        let points = ((0, 1), (1.4, 1.05), (2.8, 1.35), (2.7, 2.5), (2, 3))
        
        set-style(mark: (symbol: "|", width: 0.3))
        
        for (i, p) in points.slice(0, -1).enumerate() {
          line(p, points.at(i + 1), stroke: blue.transparentize(50%))
          
        }
    
        let points = ((5, 1), (5.3, 1), (5.6, 1), (5.9, 1), (6.2, 1.05), (6.5, 1.05), (6.8, 1.1), (7.1, 1.15), (7.4, 1.2), (7.7, 1.3), (8, 1.5), (8.1, 2), (7.8, 2.35), (7.5, 2.6), (7.2, 2.9), (7, 3))
        
        set-style(mark: (symbol: "|", width: 0.3))
        
        for (i, p) in points.slice(0, -1).enumerate() {
          line(p, points.at(i + 1), stroke: blue.transparentize(50%))
          
        }
      }))
  

      Una corba és de dimensió 1 però està en un pla.

      #pause

      $
      hausdorff = lim_(delta -> 0)  inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
    $
    ]
  ]
  
  

})

*/

#theme.slide(self => [
  #card(self.colors.primary)()[
    *Dimensió de Hausdorff*
  
    Definició complexa basada en conceptes topològics.

    #set text(18pt)
    $
      hausdorff = lim_(delta -> 0)  inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
    $
    
    $
    dim_"H " A = inf{s >= 0 : cal(H)^s (A) = 0} = sup{s >= 0 : cal(H)^s (A) = +infinity}
    $
  ]

  #pause

  #card(self.colors.primary)()[
    *Dimensió auto-similar* (fractals recursius)
  
    Es basa en les proporcions entre el conjunt original i cada conjunt còpia ($r_i$).
  
    $
    sum^n_(i=1) r_i^s = 1
    $
    
  ]

])




#theme.slide(self => [
  Dimensions fractals $-->$ *"mesuren" la rugositat* d'un objecte i pot ser decimal
  
  *Condició del conjunt obert* $-->$ Ambdues dimensions iguals #pause

  #pause

  
  #grid(columns: (1fr, 1fr, 1fr), gutter: 1em, align: top,
    card(self.colors.primary)()[
      *Conjunt de Cantor*

      Dimensió topològica 0

      $dim_"H " C = \ = log_3(2) approx "0,6309"$

      #image("cantor_2.png", width: 100%)
      #pause

    ],
    
    card(self.colors.primary)()[
      *Triangle de Sierpinski*

      Dimensió topològica 1

      $
      dim_"H " S = \ = log_2(3) approx "1,585"
      $

      #align(center, image("sierpinski_one.png", width: 80%))
      
      #pause
    ]
    ,
    card(self.colors.primary)()[
      *Corba de Koch*

      Dimensió topològica 1

      $
      dim_"H " K = log_3 4approx "1,262"
      $

      #image("koch_one.png", width: 100%)
    ]
  )
 
])

= L'estudi computacional

Part pràctica. Generació de fractals


== Generació de fractals linears

#columns[
  
]

#image("typst.png", width: 100pt)

Fractals generades amb el llenguatge tipogràfic *Typst*


#pause

Tots els algorismes són *originals*

#pause

S'ha generat el _conjunt de Cantor_, el _triangle de Sierpinski_ i la _corba de Koch_

---

#align(center, [
  #image("cantor.png", width: 120%)

  *Conjunt de Cantor*

  Recursivitat simple
])

---

#[
  #set text(18pt)

  #pseudocode-list[
    + *algorithm* cantor *is*
      + *input* interval $A = [A_1, A_2]$, integer $i$
      + *output* none
      + *if* $i$ *is* 0 *then*
        + draw line between $A_1$ and $A_2$
      + *else*
        + $i <- i - 1$
        + $B <- [A_1, A_1 + (A_2 - A_1) dot 1slash 3]$
        + $C <- [A_1 + (A_2 - A_1) dot 2 slash 3, A_2 ]$
        + cantor $B, i$
        + cantor $C, i$
      + *end*
  ]
]


#align(center, [

  #image("sierpinski.png")
  *Triangle de Sierpinski*

  Recursivitat simple
])

---

#[
  #set text(17pt)
  #pseudocode-list[
    + *algorithm* sierpinski *is*
      + *input* points $a,b,c$, integer $i$
      + *output* none
      + *if* $i$ *is* 0 *then*
        + draw filled triangle at points $t$
      + *else*
        + $i <- i - 1$ 
        + _left_ $<-$ average of points $a$ and $b$
        + _down_ $<-$ average of points $a$ and $c$
        + _right_ $<-$ average of points $b$ and $c$
        + sierpinski $a,$ _left_, _down_, $i$
        + sierpinski _left_, $b$, _down_, $i$
        + sierpinski _down_, _right_, $c, i$
      + *end*
    + *end*
  ]

]

#align(center, [
  #image("koch.png", width: 103%)

  *Corba de Koch*

  Recursivitat i geometria analítica
])

---

#[
  #set text(14pt)

  #pseudocode-list[
    + *algorithm* koch *is*
      + *input* points $a,b$, integer $i$
      + *output* none
      + *if* $i$ *is* 0 *then*
        + draw line between $a$ and $b$
      + *else*
        + $i <- i - 1$ 
        + $arrow(v) <-$ vector from $a$ to $b$
        + _ang_ $<-$ atan2 $v_x, v_y$
        + _side_ $<-$ $1/3 arrow(v)$
        + $arrow(p) <- arrow(a) + 1/3 arrow(v)$
        + $arrow(q) <- arrow(a) + 2/3 arrow(v)$
        + $t <- arrow(p) + (
          abs(#[_side_]) * cos(60º + #[_ang_]),
          abs(#[_side_]) * sin(60º + #[_ang_]),
        )$
        + koch $a, p, i$
        + koch $p, t, i$
        + koch $t, q, i$
        + koch $1, b, i$
      + *end*
  ]
]


== Generació del conjunt de Mandelbrot

#align(center)[
  #image("mandelbrot_set.png", height: 220pt)

  $
  z_(n+1) = z_n^2 + c, wide z_0 = 0
  $
]

#pause

*Pàgina web interactiva* per explorar el *conjunt de Mandelbrot*

#pause

Desenvolupada amb *OpenGL* //, un ràpid sistema de renderització de gràfics

#pause

Projecte de *gran complexitat*








= Conclusions
== Valoració del treball

*Ampli abast* del treball: *matemàtiques avançades* i *programació*

#pause

*Rigorositat matemàtica* satisfactòria, amb certa *complexitat*

#pause

Útil per a *estudis posteriors*

#pause

Varietat de *llenguatges de programació* (_Typst_, _TypeScript_ i _GLSL_)



== Futures possibilitats

#align(center)[
  #image("julia.png", width: 380pt)
]

#footnote[Imatge: Georg-Johann - CC BY SA 3.0]


Propietats dels *conjunt de Mandelbrot* i d'altres fractals

#pause

*Estudi computacional* més exhaustiu

#pause

*Optimització* de la generació de fractals

#meanwhile

#set page(background: [
  #place(center+horizon)[
      
    #image("cover.png", width: 150%)
  ]
])

#theme.focus-slide[
   
  #text(weight: "extrabold")[Gràcies per la vostra atenció!]
]

#theme.focus-slide[
  #text(60pt)[_Demo_]
]

