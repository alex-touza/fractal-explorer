#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw


= Introducció a la geometria fractal

En aquest primer capítol, s'exposarà el concepte de fractal. Es discutirà el seu origen i les característiques associades a ell, així com la seva utilitat en altres àrees.
/*
En aquest primer capítol, s'exposarà el concepte de _fractal_ i es definirà de forma matemàtica, explorant els diferents significats que s'han associat a aquest terme al llarg de les dècades. Després, es definiran les diferents _dimensions_ que es poden calcular d'aquest objecte matemàtic.
*/


== La geometria fractal a la natura


La geometria fractal és un dels camps de les matemàtiques que més ha despertat la curiositat del públic per la seva bellesa, així com per la seva omnipresència a la natura. Es solen associar les fractals amb formes com flocs de neu (@floc_de_neu) i cols autosimilars (@romanesco).

#grid(columns: (1fr, 1fr), gutter: 2em)[
  #figure(caption: [Floc de neu. _Domini públic._])[
    #image("../images/floc de neu.png", height: 150pt)
  ] <floc_de_neu>
][
  #figure(caption: [
    Patrons fractals en un cristall congelat. _By Schnobby - Own work, CC BY-SA 3.0, \<https://commons.wikimedia.org/w/index.php?curid=19055302>_
  ])[
    #image("../images/cristall congelat (Schnobby).png", height: 150pt)
  ] <cristall_congelat>
][
  #figure(
    caption: [
      Un romanesco, un tipus de col que presenta autosimilitud. _Ioangogo - Own work, CC BY-SA 4.0, \<https://commons.wikimedia.org/w/index.php?curid=39553243>_
    ]
  )[
    #image("../images/romanesco (loangogo).png", width: 200pt, height: 150pt)
  ] <romanesco>
][
  #figure(caption: [
    Dendrita d'òxid de manganès formada en pedra calcària. Escala en mil·límetres. _Mark A. Wilson (Department of Geology, The College of Wooster)._
  ])[
    #image("../images/dendrites (Wilson).png", width: 200pt, height: 150pt)
  ] <dendrita>
]

Benoît Mandelbrot va

És incorrecte, tanmateix, pensar que tota la g

Això no obstant, els fractals també són una bona representació de la realitat. Si bé la geometria euclidiana, a la qual estem acostumats, acaba sent llisa quan ens hi apropem prou, això no representa amb precisió el món natural. La geometria fractal té un enfocament diferent i considera que les formes no són llises, sinó infinitament rugoses.

Per aquest motiu,

La geometria fractal és un d'aquells conceptes matemàtics que, quan hom els coneix, els observa a tot


== Definició de fractal
La definició d'un fractal no és tan senzilla com hom podria pensar. Hi ha diverses característiques que es solen associar als fractals @falconer-properties @mandelbrot:

- *Irregularitat geomètrica.* No es poden descriure completament a partir de la geometria euclidiana convencional, si no és amb una definició recursiva (i.e. cíclica, que es conté a si mateixa).

- *Autosimilitud exacta o parcial.* Com a conseqüència de la propietat anterior, molts fractals es contenen a si mateixos, és a dir, que si desenvolupem o representem la seva definició podem trobar còpies de si mateix. Això és evident en el cas de definicions clarament recursives, com el triangle de Sierpinski, però també es troba en fractals definits de formes diferents, com el conjunt de Mandelbrot, on aquesta autosimilitud és absolutament inesperada.

- *Estructura detallada minúscula.* Les formes geomètriques convencionals, si ens hi apropem suficient, acaben semblant llises. En canvi, els fractals tenen una rugositat que sovint és infinita (al següent apartat es defineix formalment aquest terme).

- *Definició simple.* Les fractals tenen definicions molt senzilles. Això, considerant les propietats anteriors, és sorprenent. Alguns fractals s'obtenen amb un algoritme recursiu, de manera que successives iteracions d'aquest porten a una aproximació més exacta de la fractal.

  Aquesta característica resulta, a la vegada, útil i problemàtica. És útil perquè facilita molt la seva representació ---són increïblement senzills de generar amb un llenguatge de programació---, però és problemàtica perquè aleshores és més complicat estudiar les

- *Dificultats en la mesura.* Sovint resulta inútil realitzar mesures comunes com la llargada o l'àrea en els objectes fractals, ja que aquestes són o bé impossibles de fer o resulten en valors nuls o infinits.

Properament veurem, tanmateix, que no tots els fractals comparteixen totes aquestes característiques. Per aquest motiu, no existeix una sola definició de fractal; aquest terme s'utilitza més àmpliament per designar qualsevol forma geomètrica que presenti alguna de les propietats anteriors, especialment l'autosimilitud i l'estructura detallada minúscula.

I aquesta, de fet, era la intenció de Mandelbrot quan va introduir el terme. Segons ell, l'obsessió pel formalisme dels matemàtics no eñls