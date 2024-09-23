#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw
#import "@preview/dashy-todo:0.0.1": todo


= Introducció a la geometria fractal

En aquest primer capítol, s'exposarà breument la història de la geometria fractal i es discutiran les característiques associades a ella, així com la seva utilitat en altres àrees.
/*
En aquest primer capítol, s'exposarà el concepte de _fractal_ i es definirà de forma matemàtica, explorant els diferents significats que s'han associat a aquest terme al llarg de les dècades. Després, es definiran les diferents _dimensions_ que es poden calcular d'aquest objecte matemàtic.
*/

#def[Derivable gairebé pertot][
  Una funció $f$ és *derivable gairebé pertot* si el conjunt de punts $A = {x : exists.not f'(x)} $ (els punts en què la derivada no existeix) és finit o comptable.#footnote([
    Formalment, és quan el conjunt de punts és de mesura nul·la. Tots els conjunts finits o comptables són nuls, però també existeixen conjunts infinits o no comptables que són nuls. S'ha optat per simplificar la definició i així evitar introduir el concepte de mesura a aquest primer capítol.
  ])

  Anàlogament, una funció $f$ és *no derivable gairebé pertot* si el conjunt de punts $B = {x : exists f'(x)}$ (els punts en què la derivada existeix) és finit o comptable.
] <derivable_gairebe_pertot>
/*
#def[Conjunt dens][
  Donat els conjunts $A$ i $X$, $A$ és un conjunt dens a $X$ si compleix alguna d'aquestes condicions (només es llisten les rellevants):
  
  #enum(numbering: "(I)")[
    El subconjunt tancat de $X$ (informalment, que conté el seu contorn) més petit contenint $A$ és $X$ mateix.
  ][
    Existeix una intersecció entre $A$ i tots els subconjunts oberts (és a dir, que no contenen el seu contorn) no buits de $X$.
  ][
    Qualsevol punt de $X$ pertany a $A$ o és un punt límit de $A$.
  ]
]
*/

== Origen de la geometria fractal

=== Antecedents històrics

=== Weierstrass i les corbes no derivables
/*
Al llarg de la història de les matemàtiques, s'han formulat diversos conjunts i formes geomètriques que avui dia considerem fractals.
*/
Les matemàtiques avançades sovint es centren només en funcions derivables, és a dir, aquelles formes en què és possible dibuixar una recta tangent a qualsevol punt: molts dels conceptes de càlcul depenen de la derivabilitat de l'objecte matemàtic que s'estudia. #todo[Exemple de funció derivable i funció no derivable?]

// Aquesta concepció prové originalment de Isaac Newton

El càlcul, una de les branques més importants de les matemàtiques, concebut de forma simultània per Newton i Leibniz, es basava en la suposició que, donada una funció $f$ que és contínua a l'interval $[a,b]$, $f$ és derivable gairebé pertot punt dins $[a,b]$ (@derivable_gairebe_pertot). Tots els grans matemàtics d'abans del segle XX, com Gauss i Cauchy, suposaven que això era cert, o almenys no van dir el contrari.

El matemàtic i físic francès André-Marie Ampère va fer una demostració ---no gaire rigurosa--- d'aquesta conjectura, basant-se en un teorema sobre les corbes contínues (@teorema_ampere) @Kucharski2022. 

#theorem[Teorema d'Ampère de les corbes contínues#footnote[
  No confondre amb les lleis de força i circuits d'Ampère.
]][
  Tota corba contínua ha de tenir seccions que siguin creixents, decreixents o completament horitzontals.
] <teorema_ampere>


El teorema d'Ampère, tanmateix, no considera el cas que aquestes seccions siguin infinitament petites.



Durant la dècada de 1860, Bernhard Riemann va proposar una funció analítica#footnote[
  Cal aclarir que, tot i ser definides amb una suma infinita, les funcions de Riemann i Weierstrass són analítiques perquè la sèrie és convergent, és a dir, les seves sumes parcials s'acosten a un valor concret. Una funció com $f(x)= sum^infinity_(n=1) x^n$ no és analítica perquè la sèrie no és convergent.
] contínua que no era, suposadament, derivable enlloc. Es defineix amb l'expressió

$
R(x)=sum^infinity_(n=1) sin(n^2 x)/n^2
$




Tanmateix, Riemann no va demostrar que fos així. Durant el segle XX s'ha comprovat que la funció de Riemann sí que és derivable en punts concrets @Hardy1916 @Gerver1969 @Gerver1971: per exemple, Hardy va provar la derivabilitat per a punts $r pi$ tal que $r$ és nombre irracional i Gerver va provar la derivabilitat en punts tals que la variable independent pren un valor de $pi$ multiplicat per una fracció de nombres enters senars. Així doncs, com que el conjunt de punts en què la derivada existeix és comptable, la funció de Riemann és no derivable gairebé pertot.

Finalment, la primera funció que es va demostrar que no era derivable en cap punt, i que per tant falsava el teorema d'Ampère va ser proposada per Karl Weierstrass el 1872:

$
W(x)=sum^infinity_(n=1) b^n cos(a^n x pi)
$

tal que $0 < a < 1$, $b$ és un enter positiu i $display(a b > 1 + 3/2pi)$.
#todo[Mostrar gràfiques de les dues funcions.]

Això va tenir tal impacte en les matemàtiques de l'època, que Poincaré es va referir a aquesta funció com un "monstre" i un "ultratge contra el sentit comú". L'existència d'una funció així implicava que la proposició en què es basava el càlcul era falsa, per culpa de les definicions imprecises i demostracions que abusaven de la intuïció.

Aquesta fita va ser una autèntica lliçó per als matemàtics; mostrava com d'important era mantenir la rigorositat i no fer masses suposicions de les quals més tard ens podem penedir. En tot cas, la funció de Weierstrass obria les portes a un nou món matemàtic, el món de les corbes infinitament rugoses/*; és a dir, les fractals. De fet, avui dia la seva gràfica es consideraria un objecte fractal. */

=== Cantor, Koch i la mirada a l'infinit

La funció de Weierstrass va començar a despertar la curiositat en el "món rugós"; durant les següents dècades, es van idear nous objectes matemàtics que van anar construint la geometria fractal com la coneixem avui dia. Les primeres

Georg Cantor, el pare de la teoria de conjunts, qui va assistir a les classes de Weierstrass, va crear el 1883 una funció $psi$ amb unes característiques molt interessants, definida a l'interval $[0, 1]$: conté diverses simetries entre punts i és derivable gairebé pertot, excepte un conjunt de punts molt concrets, que anomenem conjunt de Cantor ($cal(C)$).

Més tard, el 1904 Hedge von Koch va ,
/*
$
psi'(x) = cases(0 wide& "si" x in.not C,+infinity & "si" x in C) 
$
*/



Els objectes matemàtics mencionats en aquest apartat (la funció de Cantor, el conjunt de Cantor i la corba de Von Koch) requereixen un desenvolupament més profund; es defineixen amb detall a l'apartat corresponent.



=== Einsein i el moviment brownià
=== Mandelbrot i els fractals financers


El matemàtic polonès Benoît Mandelbrot (1924#{sym.dash.en}2010) va començar a observar "rugositats" a una multitud d'àrees de la realitat. Les seves investigacions consistien estudiar el comportament de les fluctuacions de diferents variables, començant pels mercats financers i els preus de productes com el cotó i el blat, fins les inundacions del riu Nil. Durant els seus primers estudis, es va adonar que resultats exactes requerien considerar una "variància infinita", ben lluny de les aproximacions poc realistes dels models de l'època. @Gomory2010

Aquesta nova perspectiva es va veure reflectida en el seu article _How Long is the Coast of Britain? Statistical Self-Similarity and Fractional Dimension_ (en català, _Quina és la longitud de la costa de Gran Bretanya? Autosimilitud estadística i dimensió fraccionària_) @Mandelbrot1967, en què estudiava la rugositat ("el grau de complicació") de les corbes geogràfiques. Mandelbrot va proposar una dimensió $D$ que ho mesura (s'explica al capítol #todo[Afegir referència al capítol corresponent]).

L'objectiu de Mandelbrot era mirar la realitat d'una forma diferent.

Els lectors s'hauran adonat que, des del començament d'aquest capítol sobre la història de la geometria fractal, encara no hem fet servir el terme _fractal_---i és que no va ser fins el 1975 quan Mandelbrot va introduir els termes _fractal_ i _objecte fractal_.


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
La definició d'un fractal no és tan senzilla com hom podria pensar. Hi ha diverses característiques que es solen associar als fractals @falconer @Mandelbrot1987:

- *Irregularitat geomètrica.* No es poden descriure completament a partir de la geometria euclidiana convencional, si no és amb una definició recursiva (i.e. cíclica, que es conté a si mateixa).

- *Autosimilitud exacta o parcial.* Com a conseqüència de la propietat anterior, molts fractals es contenen a si mateixos, és a dir, que si desenvolupem o representem la seva definició podem trobar còpies de si mateix. Això és evident en el cas de definicions clarament recursives, com el triangle de Sierpinski, però també es troba en fractals definits de formes diferents, com el conjunt de Mandelbrot, on aquesta autosimilitud és absolutament inesperada.

- *Estructura detallada minúscula.* Les formes geomètriques convencionals, si ens hi apropem suficient, acaben semblant llises. En canvi, els fractals tenen una rugositat que sovint és infinita (al següent apartat es defineix formalment aquest terme).

- *Definició simple.* Les fractals tenen definicions molt senzilles. Això, considerant les propietats anteriors, és sorprenent. Alguns fractals s'obtenen amb un algoritme recursiu, de manera que successives iteracions d'aquest porten a una aproximació més exacta de la fractal.

  Aquesta característica resulta, a la vegada, útil i problemàtica. És útil perquè facilita molt la seva representació ---són increïblement senzills de generar amb un llenguatge de programació---, però és problemàtica perquè aleshores és més complicat estudiar les

- *Dificultats en la mesura.* Sovint resulta inútil realitzar mesures comunes com la llargada o l'àrea en els objectes fractals, ja que aquestes són o bé impossibles de fer o resulten en valors nuls o infinits.

Properament veurem, tanmateix, que no tots els fractals comparteixen totes aquestes característiques. Per aquest motiu, no existeix una sola definició de fractal; aquest terme s'utilitza més àmpliament per designar qualsevol forma geomètrica que presenti alguna de les propietats anteriors, especialment l'autosimilitud i l'estructura detallada minúscula.

I aquesta, de fet, era la intenció de Mandelbrot quan va introduir el terme. Segons ell, l'obsessió pel formalisme dels matemàtics no eñls