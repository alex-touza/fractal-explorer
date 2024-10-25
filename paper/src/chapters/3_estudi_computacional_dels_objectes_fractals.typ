#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw
#import "@preview/lovelace:0.3.0": *

= Estudi computacional dels objectes fractals

En aquest últim capítol, s'exposaran breument algunes tècniques de generació de fractals mitjançant programes informàtics. Primer, estudiarem la generació de fractals simples, i després, la generació de fractals més complexos.

== Generació de fractals simples

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
]

=== Geometria analítica

Tant la construcció intuïtiva com l'algoritme de generació del triangle de Sierpinski són bastant trivials. En canvi, altres fractals, com la corba de Koch, tenen una implementació més complicada tot i tenir una construcció geomètrica simple. Una forma de traduir els passos d'alt nivell de la construcció a un altre algoritme que el pugui entendre l'ordinador, és fer servir la geometria analítica. Convertint cada pas a una operació vectorial o matricial es pot escriure més còmodament el codi per a la fractal.

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
== Generació de fractals complexos

Fins ara hem mostrat només fractals estrictament geomètrics. En fractals més complexos#footnote[_No pun intended._], com els conjunts de Julia, l'algoritme té un enfocament bastant diferent per la seva naturalesa. S'ha d'executar un algorisme per a cadascun del punts del pla, cosa que és molt costosa.

Per desgràcia, no existeix cap forma molt bona d'optimitzar aquest procés. El que sí que es pot fer és escollir un llenguatge ràpid. Per a la visualització en dues i tres dimensions, una opció molt popular és OpenGL2, que executa el codi a la targeta gràfica directament. Aquest llenguatge és molt complicat, però assegura un rendiment immillorable.

Durant aquest projecte, de forma paral·lela a l'estudi matemàtic, s'ha iniciat la creació d'un programa d'aquestes característiques per generar els conjunts de Julia. S'espera poder completar-lo al llarg de les properes setmanes.