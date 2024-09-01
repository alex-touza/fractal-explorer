#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw

= Introducció a la geometria fractal

En aquest primer capítol, s'exposarà el concepte de _fractal_ i es definirà de forma matemàtica, explorant els diferents significats que s'han associat a aquest terme al llarg de les dècades. Després, es definiran les diferents _dimensions_ que es poden calcular d'aquest objecte matemàtic.


#def[Diàmetre][
  Donat un conjunt $E = {x_1, x_2, ..., x_n}$, definim el seu _diàmetre_, denotat amb $abs(E)$, com la distància més gran possible entre qualsevol parella de punts. Simbòlicament, $abs(E) = sup { d(x_i, x_j) : x_i,x_j in E}$.
]

#def[Recobriment-$delta$][
  Donat un conjunt $A$, una cobertura-$delta$ és una col·lecció comptable ${ E_i }$ de conjunts amb diàmetres $abs(E_i) <= delta$ tals que el conjunt $A$ conté la unió de tots els conjunts de la col·lecció. Simbòlicament#footnote[La definició real d'un recobriment fa ús de _conjunts indexats_ però s'ha optat per usar una definició simplificada.]: $ C_delta (A) = {E_i : abs(E_i) <= delta}, A subset.eq union.big_i E_i $
] <recobriment-delta>

#def[Funció gamma][
  La funció gamma $Gamma(z)$ està definida als nombres complexos amb part real positiva i és una extensió del concepte de factorial, definit només a nombres enters positius, a aquest conjunt superior. La funció es defineix així:
  
  $
  Gamma(z) = integral^infinity_0 t^(z-1) e^(-t) dif t
  $
  
  Similarment al factorial, es compleix que, per a tot $n$ enter positiu, $Gamma(n) = (n-1)!$, i per a tot $z$ complex, $Gamma(z+1) = z Gamma(z)$.
] <funcio-gamma>


== La geometria fractal i les seves aplicacions


La geometria fractal és un dels camps de les matemàtiques que més ha despertat la curiositat del públic per la seva autèntica bellesa. Aquestes formes presenten un detall increïble a partir d'una definició realment simple.

Benoît Mandelbrot va

Això no obstant, els fractals també són una bona representació de la realitat. Si bé la geometria euclidiana, a la qual estem acostumats, acaba sent llisa quan ens hi apropem prou, això no representa amb precisió el món natural. La geometria fractal té un enfocament diferent i considera que les formes no són llises, sinó infinitament rugoses.

Per aquest motiu,


== Definició de fractal
La definició d'un fractal no és tan senzilla com hom podria pensar. Hi ha diverses característiques que es solen associar als fractals @falconer-properties @mandelbrot:

- *Irregularitat geomètrica.* No es poden descriure completament a partir de la geometria euclidiana convencional, si no és amb una definició recursiva (i.e. cíclica, que es conté a si mateixa).

- *Autosimilitud exacta o parcial.* Com a conseqüència de la propietat anterior, molts fractals es contenen a si mateixos, és a dir, que si desenvolupem o representem la seva definició podem trobar còpies de si mateix. Això és evident en el cas de definicions clarament recursives, com el triangle de Sierpinski, però també es troba en fractals definits de formes diferents, com el conjunt de Mandelbrot, on aquesta autosimilitud és absolutament inesperada.

- *Estructura detallada minúscula.* Les formes geomètriques convencionals, si ens hi apropem suficient, acaben semblant llises. En canvi, els fractals tenen una rugositat que sovint és infinita (al següent apartat es defineix formalment aquest terme).

- *Definició simple.* Les fractals tenen definicions molt senzilles. Això, considerant les propietats anteriors, és sorprenent. Alguns fractals s'obtenen amb un algoritme recursiu, de manera que successives iteracions d'aquest porten a una aproximació més exacta de la fractal.

  Aquesta propietat resulta, a la vegada, útil i

- *Dificultats en la mesura.* Sovint resulta inútil realitzar mesures comunes com la llargada o l'àrea en els objectes fractals, ja que aquestes són o bé impossibles de fer o resulten en valors nuls o infinits.

Properament veurem, tanmateix, que no tots els fractals comparteixen totes aquestes característiques. Per aquest motiu, no existeix una sola definició de fractal; aquest terme avui dia s'utilitza més àmpliament per designar qualsevol forma geomètrica que presenti alguna de les propietats anteriors, especialment l'autosimilitud i l'estructura detallada minúscula.


