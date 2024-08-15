#set text(font: "New Computer Modern", size: 11pt, lang: "ca")
#set par(leading: 1.15em, justify: true, linebreaks: "optimized", first-line-indent: 2em)
#set heading(numbering: "1.1.")

#let abstracttitle(t) = {
  show text: smallcaps
  set text(size: 17pt)
  heading(outlined: false, numbering: none, t)
}

#pagebreak()

#abstracttitle("Abstract")


#abstracttitle("Resumen")

#pagebreak()

#outline(title: "Taula de continguts", indent: 1em)
#pagebreak()

= Introducció als fractals

En aquest primer capítol, s'exposarà el concepte de _fractal_ i es definirà de forma matemàtica, explorant els diferents significats que s'han associat a aquest terme al llarg de les dècades. Després, es definiran les diferents _dimensions_ que es poden calcular d'aquest objecte matemàtic.

== La geometria fractal i les seves aplicacions


La geometria fractal és un dels camps de les matemàtiques que més ha despertat la curiositat del públic per la seva autèntica bellesa. Aquestes formes presenten un detall increïble a partir d'una definició realment simple.

Això no obstant, els fractals també són una bona representació de la realitat. Si bé la geometria euclidiana, a la qual estem acostumats, acaba sent llisa quan ens hi apropem prou, això no representa amb precisió el món natural. La geometria fractal té un enfocament diferent i considera que les formes no són llises, sinó infinitament rugoses.

Per aquest motiu,


== Definició de fractal
La definició d'un fractal no és tan senzilla com hom podria pensar. Hi ha diverses característiques que es solen associar als fractals @falconer-properties @mandelbrot:

- *Irregularitat geomètrica.* No es poden descriure completament a partir de la geometria euclidiana convencional, si no és amb una definició recursiva (i.e. cíclica, que es conté a si mateixa).
- *Autosimilitud.* Com a conseqüència de la propietat anterior, molts fractals es contenen a si mateixos, és a dir, que si desenvolupem o representem la seva definició podem trobar còpies de si mateix. Això és evident en el cas de definicions clarament recursives, com el triangle de Sierpinski, però també es troba en fractals definits de formes diferents, com el conjunt de Mandelbrot.

  Aquesta autosimilitud no sempre és exacta,

- *Estructura detallada minúscula.* Les formes geomètriques convencionals, si ens hi apropem suficient, acaben semblant llises. En canvi, els fractals tenen una rugositat que sovint és infinita (al següent apartat es defineix formalment aquest terme).

Properament veurem, tanmateix, que no tots els fractals comparteixen totes aquestes característiques. Per aquest motiu, no existeix una sola definició de fractal; aquest terme avui dia s'utilitza més àmpliament per designar qualsevol forma geomètrica que presenti alguna de les propietats anteriors, especialment l'autosimilitud i l'estructura detallada minúscula.


== Dimensions d'un fractal
El concepte de dimensió, en matemàtiques avançades, té molts significats; no es limita només al nombre d'eixos per representar una forma geomètrica a l'espai euclidià. Aquesta mesura, per als matemàtics, s'anomena _dimensió topològica_.

Si bé la dimensió topològica es pot entendre intuïtivament, la seva definició formal no és tan senzilla.

= Estudi matemàtic dels fractals

== Fractals de recursivitat geomètrica
Aquests tipus de fractals també s'anomenen Sistemes de Funcions Iterades, o _IFS_ per abreviar.

=== Triangle i catifa de Sierpinski

== Fractals de funcions sobre el pla

=== Conjunts de Julia

=== Conjunt de Mandelbrot

=== Fractal de Newton

== Atractors estranys
=== Teoria del caos

=== Atractor de Lorentz

== Fractals tridimensionals
Quaternions

= Generació de fractals

Explicació de la part pràctica del projecte.

== Anàlisi algorísmic

Complexitat temporal dels algoritmes per generar cada fractal.

== Entorn de generació

Explicació de com aplicar els algoritmes. Amb quin llenguatge, en quin entorn. També mostrar la interfície del programa.

==


= Conclusió

= Annexos

== Annex 1: Glossari

/ complexitat temporal: Com creix el temps que triga a executar-se un algoritme en funció de les variables d'entrada. Per exemple, $O(n^2)$ indica que si es dobla el nombre d'ítems d'entrada, es quadruplica el temps d'execució.

== Annex 2: Descripció de la interfície de l'explorador de fractals


== Annex 3: Fragments de codi

= Bibliografia

#sym.space.nobreak

#bibliography("bib.yaml", style: "american-psychological-association", title: none, full: true)