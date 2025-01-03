#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw
#import "@preview/lovelace:0.3.0": *

= Estudi computacional dels objectes fractals

En aquest últim capítol, s'exposaran breument algunes tècniques de generació de fractals mitjançant programes informàtics. Primer, estudiarem la generació de fractals simples, i després, la generació de fractals més complexes.

== Generació de fractals simples

//== Algorismes recursius
=== Recursivitat
La tècnica més emprada per generar fractals simples és la recursivitat, ja que la pròpia definició de moltes d'elles la fa servir. Les tres fractals generades íntegrament en aquesta memòria ---el conjunt de Cantor (@fig-cantor), el triangle de Sierpinski (@fig-sierpinski) i la corba de Koch (@fig-koch-iteracions)--- fan servir recursivitat.

En informàtica, la recursivitat distingeix dos conceptes: el _cas base_, que és un valor fix conegut per a algun valor de variable independent, i el _cas recursiu_, que es defineix fent ús del propi algoritme. L'exemple clàssic és la computació del factorial, però aquí en mostrarem un de més interessant: la computació dels nombres combinatoris. Pel triangle de Pascal o de Tartaglia, tenim la següent relació de recurrència (que és el cas recursiu) $ vec(n, k) = vec(n-1, k-1) + vec(n-1, k) $

amb el cas base $vec(n, 0) = 1$

Un codi que calcula un nombre combinatori és el següent:

#pseudocode-list[
  + *algorithm* nombres-combinatoris *is*
    + *input* positive integers $n, k$
    + *output* positive integer
    + *if* $k$ *is* 0 *then*
      + *return* 1
    + *else*
      + *return* nombres-combinatoris $n-1, k-1$ + nombres-combinatoris $n-1, k$
    + *end*
  + *end*
]


En fractals, no tenim cas base, només cas de recurrència. Aleshores, el programa generador de fractals ha de tenir un límit d'iteracions per no causar una excepció al sistema. Una forma de fer això és mantenir un comptador $i$ que vagi disminuint a cada iteració i que anem arrossegant com a paràmetre.

Per exemple, aquest és el pseudocodi per al triangle de Sierpinski, que comença amb el triangle definit pels punts $a,b,c$ i fa $i$ iteracions:

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

//== Aplicació de geometria analítica
=== Geometria analítica

Tant la construcció intuïtiva com l'algoritme de generació del triangle de Sierpinski són bastant trivials. En canvi, altres fractals, com la corba de Koch, tenen una implementació més complicada tot i tenir una construcció geomètrica simple. Una forma de traduir els passos d'alt nivell de la construcció a un altre algoritme que pugui entendre l'ordinador, és fer servir la geometria analítica. Convertint cada pas a una operació vectorial o matricial es pot escriure més còmodament el codi per a la fractal.

Es mostra aquí el pseudocodi per la corba de Koch:

#pseudocode-list[
  + *algorithm* koch *is*
    + *input* points $a,b$, integer $i$
    + *output* none
    + *if* $i$ *is* 0 *then*
      + draw line between $a$ and $b$
    + *else*
      + $i <- i - 1$ 
      + $arr(v) <-$ vector from $a$ to $b$
      + _ang_ $<-$ atan2 $v_x, v_y$
      + _side_ $<-$ $1/3 arr(v)$
      + $arr(p) <- arr(a) + 1/3 arr(v)$
      + $arr(q) <- arr(a) + 2/3 arr(v)$
      + $t <- arr(p) + (
        abs(#[_side_]) * cos(60º + #[_ang_]),
        abs(#[_side_]) * sin(60º + #[_ang_]),
      )$
      + koch $a, p, i$
      + koch $p, t, i$
      + koch $t, q, i$
      + koch $1, b, i$
    + *end*
]
/*
== Gràfics _turtle_

=== Funcionament

== Sistemes de Lindenmayer

=== Funcionament

==== Motivació

==== Definició formal

==== Exemple senzill

===
*/
/*
=== Punt  mòbil
Una tècnica útil per generar alguns fractals és el punt mòbil. Consisteix en mantenir una posició per saber on començar a dibuixar la fractal. L'avantatge d'aquest mètode és que és ben senzill d'aplicar sense recursivitat, però és només útil per a fractals molt simples. Vegem un exemple.

Sigui $F_0$ la primera iteració de la nostra fractal. $F_0$ consistirà en un quadrat de costat $c$ a $RR^2$ i el punt mòbil $P$ seguirà la igualtat
$
P_k = (c / display(floor(x/2)dot 2))
$

#let my_fractal(n) = {
  canvas({
      import draw: *

      let c = 4

      let p(k) = {
        return ((calc.floor(k / 2 + 1)*2), (calc.floor((k+1)/2)*2) )
      }

      
      
      //line((0, 0), (5, 0), (5, -5), (0, -5), close: true)

      for i in range(n) {
        let np = p(i+1)

        line(p(i), np)

        
      }

      
    })
}

#figure(caption: [Representació de $F_0$])[
  #grid(columns: 2, gutter: 2em)[
    #my_fractal(5)
  ][
    #my_fractal(1)
  ]
]
*/
== Generació de fractals complexos //no lineals

Fins ara hem mostrat només fractals estrictament geomètrics. En fractals més complexes#footnote[_No pun intended._], com els conjunts de Julia, l'algoritme té un enfocament bastant diferent per la seva naturalesa. S'ha d'executar un algorisme per a cadascun del punts del pla, cosa que és molt costosa.

=== Entorn
Per desgràcia, no existeix cap forma molt bona d'optimitzar aquest procés. El que sí que es pot fer és escollir un llenguatge ràpid. Per a la visualització en dues i tres dimensions, una opció molt popular és OpenGL2, que executa el codi a la targeta gràfica directament. Aquest llenguatge és molt complicat, però assegura un rendiment immillorable.

Durant aquest projecte, de forma paral·lela a l'estudi matemàtic, s'ha iniciat la creació d'un programa d'aquestes característiques per generar els conjunts de Julia. S'espera poder completar-lo al llarg de les properes setmanes.
/*

=== Sistema de coordenades

En aquest programa, cooperen dos sistemes de coordenades diferents: el de JavaScript (_screen space_), que situa el punt $(0, 0)$ a dalt a l'esquerra i el punt a baix a la dreta és $(w, h)$, on $w$ i $h$ és la resolució de la pantalla, i el de OpenGl (_clip space_), que situa el punt $(0, 0)$ al centre.#footnote[El _clip space_ també inclou els components $z$, la profunditat, i $w$, la perspectiva, però com que el conjunt de Mandelbrot és pla no ens interessen.] Ens hem d'assegurar  que, en interactuar amb el programa (moure's pel pla i ampliar-lo), les transformacions entre aquests dos sistemes siguin fetes correctament.

/* El pla complex a partir del qual es genera el conjunt de Mandelbrot l'equivaldrem al _clip space_ de OpenGL, de manera que entre aquests dos sistemes de coordenades no fem cap conversió. Ara bé, per*/

Considerem les variables d'estat _zoom_, _posX_ i _posY_. Les variables _posX_ i _posY_ es refereixen al centre al voltant del qual s'itera sobre la funció complexa. És a dir, $z = (0, 0)$ correspon al píxel $C(italic("posX"), italic("posY"))$. Amb la variable _zoom_, qualsevol punt que es mostra correspon a l'expressió $arrow(p') = arrow(c) + italic("zoom") dot arrow(p)$ on $arrow(p)$ és el vector posició del píxel. El conjunt de Mandelbrot
#figure(caption: "a")[
  #canvas({
    import draw: *

    set-style(
      mark: (fill: black, scale: 2),
      stroke: (thickness: 0.4pt, cap: "round"),
      angle: (
        radius: 0.3,
        label-radius: .22,
        fill: green.lighten(80%),
        stroke: (paint: green.darken(50%))
      ),
      content: (padding: 1pt)
    )
  
    grid((-3, -3), (3, 3), step: 0.2, stroke: gray + 0.2pt)

    circle((0, 0), radius: 0.05, fill: black)
    circle((3, 3), radius: 0.05, fill: black)
    content((0.2, 0.2), [$C$])
    content((3.2, 3.2), [$P$])

    line((-3, -3.5), (3, -3.5), mark: (start: "stealth", end: "stealth"))
    line((-3.5, -3), (-3.5, 3), mark: (start: "stealth", end: "stealth"))
    content((0, -4), [Amplada])
    content((-4.5, 0), [Alçada])
    
    content((4.5, 0), text(rgb("#0000"))[Alçada])
  })
]

---------

L'amplada i l'alçada de la part del pla complex mostrat es multiplica per $2 slash 3$ si s'amplia i es multiplica per la inversa si es redueix.

A l'algorisme també es fan servir les constants mida de la pantalla $arrow(m) = (m_1, m_2)$, on $m_1$ és l'amplada i $m_2$ l'alçada, i el factor d'ampliació $alpha$.

#pseudocode-list[
  + *algorithm* zoom *is*
    + *input* posició centre $arr(p)$, zoom $lambda$, posició cursor $arr(a)$, quantitat desplaçament $delta$
    + *output* nova posició del centre $arr(p')$, nou zoom $lambda'$
    + mida pla actual $arrow(n) := lambda dot arrow(m)$
    + nou zoom $lambda' := lambda dot alpha$
    /*
    + *if* $delta > 0$ *else*
      + mida pla nou $arrow(n') := arrow(n) dot alpha$
    + *else*
      + mida pla nou $arrow(n') := arrow(n) med slash med alpha$
    + *end*
    */
    + #comment([Situem el centre del pla $(x', y')$ a partir de la posició del cursor])
    + posició horitzontal cursor al pla $c_1 := lambda dot a_1 - n_1 slash 2$
    + posició vertical cursor al pla $c_2 := lambda dot (m_2 - a_2 )- n_2 slash 2$
    + 
    + *if* $i$ *is* 0 *then*
  ]

  /*
  simplificar i canviar a expressió matemàtica
  */
=== Algorisme 