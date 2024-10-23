#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/cetz:0.2.2": canvas, draw, plot

= Estudi matemàtic dels objectes fractals

En aquesta part del treball, s'exposaran les matemàtiques que estudien els objectes fractals. La primera secció introdueix el concepte de dimensió topològica, que contextualitza la següent secció, que tracta la dimensió fractal. La segona i tercera secció estudien els exemples més coneguts dels dos grans tipus de fractals: els sistemes de funcions iterades i els fractals de funcions sobre el pla.

A continuació, es presenten les definicions matemàtiques utilitzades en aquest capítol. Per motius de brevetat, algunes definicions conegudes al currículum de Batxillerat com la continuïtat d'una funció no s'han exposat. S'assumeix, també, un coneixement bàsic de teoria de conjunts. /*En un intent de simplificar les definicions, s'ha optat per no fer ús del terme _espai mètric_ i utilitzar més simplement el terme _conjunt_. Per aquest motiu, cal tenir en compte que sempre que es faci servir aquest últim terme, la definició és vàlida per a qualsevol espai mètric.*/


#def[Topologia sobre un conjunt][
  Una _topologia_ $tau$ sobre un conjunt $X$ és una col·lecció de subconjunts oberts de $X$ tals que el conjunt buit i $X$ mateix estan en $tau$ i es compleix que tant la intersecció com la unió dels conjunts de cada subcol·lecció finita de $tau$ està dins $tau$. Simbòlicament:

  $
  emptyset in tau, X in tau \
  forall S in tau, union.big_(O in S) O in T and sect.big_(O in S) O in T
  $

  La _topologia discreta_ és la col·lecció de tots els conjunts de $X$, i la _topologia indiscreta_ és simplement el conjunt buit i $X$.
  
  Hi ha moltes altres definicions alternatives de topologies, però aquesta és la més simple d'exposar.

  Aquesta estructura matemàtica s'exposa pel seu ús en definicions posteriors.

] <def-topologia>


#def[Espai topològic][
  Un _espai topològic_ és un parell ordenat $(X, tau)$ on $X$ és un conjunt i $tau$ és una topologia sobre $X$ (@def-topologia).
] <def-espai-topològic>

#def[Transformació homeomorfa][
  Una funció $f: A -> B$ on $A$ i $B$ són espais topològics (@def-espai-topològic) és una _transformació homeomorfa_ o un _homeomorfisme_ si es compleix que tant $f$ com $f^(-1)$ són contínues en tot el seu domini ($A$ i $B$ corresponentment) i que $f$ és bijectiva, és a dir, hi ha una relació un a un entre $A$ i $B$ (simbòlicament, $forall b in B med exists! a in A : f(a) = b$, on $exists!$ vol dir "existeix només un").
  
  Diem que dos espais $A$ i $B$ són homomòrfics si existeix una transformació homeomorfa entre ells.

  Per exemple, la funció $f(x) = x^3$ és un homeomorfisme perquè és clarament bijectiva i contínua en tot $RR$, i la seva funció inversa $f^(-1)=root(3, x)$ és contínua. En canvi, la funció $g(x)=x^2$ ni és bijectiva ni la seva funció inversa $g^(-1)=sqrt(x)$ és contínua, així que no és un homeomorfisme.

  Intuïtivament, un homeomorfisme només deforma, no talla ni enganxa, encara que a vegades aquesta simplificació sovint és errònia (com amb la transformació d'una recta a un punt, que no és un homeomorfisme).

  Determinar si una certa transformació és un homeomorfisme és un exercici comú en topologia.
] <def-homeomorfisme>

#def[Propietat topològica][
  Una propietat $P$ és _topològica_ si per a qualsevol conjunt $X$, $P$ no varia si a $X$ se li aplica una transformació homeomorfa (@def-homeomorfisme).
] <def-prop-topologica>

#def[Mesura de distància][
  Una _mesura de distància_ sobre un conjunt $M$ és una funció $d$ que obté una parella de punts en $M$ i retorna un nombre real. Simbòlicament,

  $
  d colon M times M -> RR^+ union {0}
  $

  Una mesura de distància ha de complir els següents axiomes:

  + La distància d'un punt a si mateix és nul·la: $d(x, x) = 0$

  + La distància de dos punts diferents és positiva: $x != y <=> d(x, y) > 0$

  + La distància d'un punt $x$ a un punt $y$ és la mateixa que de $y$ a $x$. $d(x, y) = d(y, x)$

  + Es compleix la desigualtat triangular: $d(x, z) <= d(x,y) + d(y, z)$

  Per exemple, la distància $n$-euclidiana sobre $RR^n$ és una funció $d colon RR^n times RR^n -> RR^+ union {0}$ definida com $d(x, y) = sqrt(sum^n_(i=0) (x_i - y_i)^n)$ on $x = (x_0, ..., x_(n-1)), y = (y_0, ..., y_(n-1))$.
] <def-mesura-distancia>

#def[Espai mètric][
  Un _espai mètric_ definit com un parell ordenat $(M, d)$ on $M$ és un conjunt i $M$ és una mesura de distància sobre $M$ (@def-mesura-distancia).
] <def-espai-mètric>


#def[Diàmetre][
  Donat un conjunt $E = {x_1, x_2, ..., x_n}$ dins un espai mètric $(M, d)$ (@def-espai-mètric), definim el seu _diàmetre_, denotat amb $abs(E)$, com la distància més gran possible entre qualsevol parella de punts. Simbòlicament, $abs(E) = sup { d(x_i, x_j) : x_i,x_j in E}$.
]


#def[Recobriment][
  Donat un conjunt $A$ dins un espai mètric $(M, d)$ (@def-espai-mètric), un _recobriment_ és una col·lecció de conjunts $cal(C) = { E_i }$ tals que la unió de tots els conjunts de la col·lecció conté el conjunt $A$.#footnote[En algunes fonts es requereix que els conjunts que formen els recobriments siguin també subconjunts de $A$. Per la geometria fractal, però, la definició presentada és més útil.] Simbòlicament, $ cal(C)(A) = {E_i } : A subset.eq union.big_(E_i in cal(C)) E_i $

  Un _recobriment obert_ és un recobriment format per conjunts oberts.
] <def-recobriment>



#def[Recobriment-$delta$][
  Donat un conjunt $A$ dins un espai mètric $(M, d)$ (@def-espai-mètric), un _recobriment-$delta$_ on $delta$ és un nombre real positiu és una col·lecció comptable ${ E_i }$ de conjunts amb diàmetres $abs(E_i) <= delta$ tals que la unió de tots els conjunts de la col·lecció conté el conjunt $A$. Simbòlicament#footnote[La definició real d'un recobriment fa ús de _conjunts indexats_ però s'ha optat per usar una definició simplificada.]: $ cal(C)_delta (A) = {E_i : abs(E_i) <= delta},   A subset.eq union.big_(E_i in cal(C)) E_i $
] <def-recobriment-delta>

#def[Malla][
  La _malla_ d'un recobriment és el diàmetre més gran dels conjunts que el formen. Simbòlicament,

  $
  "malla"(C) = sup{abs(E_i) : E_i in cal(C)}
  $
] <def-malla>

#def[Espai mètric compacte][
  Un espai mètric $(M, d)$ (@def-espai-mètric) és _compacte_ si per a qualsevol recobriment obert $cal(C)$ (@def-recobriment) existeix una subcol·lecció finita $cal(F) subset.eq cal(C)$ tal que

  $
  A subset.eq union.big_(E in cal(F)) E
  $

  Si $M subset.eq RR^n$, aleshores $(M, d)$ és compacte si $M$ és fitat i tancat. Per exemple, el conjunt $A = (0, 1)$ no és compacte perquè és obert; el conjunt $B = (-infinity, 4]$ no és compacte perquè és no fitat, i el conjunt $C = [0, 1]$ és compacte perquè és fitat i tancat.
] <def-compacte>

#def[Ordre][
  Donada una col·lecció de conjunts $cal(F)$ en un espai mètric $(M, d)$ (@def-espai-mètric), el seu _ordre_ és el major nombre de conjunts que se superposen en un sol punt. Formalment, l'ordre és l'enter més petit $k$ tal que cap punt en $M$ pertany a més de $k$ conjunts en $cal(F)$ a la vegada. Simbòlicament,

  $
  "ord"(cal(F)) = max{abs({A in cal(F) : x in A}) : x in M}
  $

  on l'operador $abs(Y)$ indica la cardinalitat del conjunt, és a dir, el nombre d'elements.
] <def-ordre>


#def[Refinament][
  Donat un recobriment $cal(C)$ (@def-recobriment) d'un espai topològic $(M, d)$ és un altre recobriment $cal(R)$ del mateix espai tal que cada conjunt de $cal(R)$ està en algun conjunt de $cal(C)$. Simbòlicament,

  $
  cal(R)(cal(C)) = {E_i : exists C in cal(C) : E_i in C },  A subset.eq union.big_(E_i in cal(C)) E_i
  $

  Intuïtivament, un refinament és un segon recobriment més petit que un primer recobriment, inclòs en aquest.
] <def-refinament>


/*
#def[Funció gamma][
  La _funció gamma_ $Gamma(z)$ està definida als nombres complexos amb part real positiva i és una extensió del concepte de factorial, definit només a nombres enters positius, a aquest conjunt superior. La funció es defineix així:
  
  $
  Gamma(z) = integral^infinity_0 t^(z-1) e^(-t) dif t
  $
  
  Es compleix que, per a tot $n$ enter positiu, $Gamma(n) = (n-1)!$, i, similarment al factorial, per a tot $z$ complex, $Gamma(z+1) = z Gamma(z)$.
] <funcio-gamma>
*/
// p.92
== Dimensió topològica
/*
A la geometria elemental, és ben conegut per tothom que un punt té dimensió 0, una recta té dimensió 1, etcètera. Però el concepte de dimensió també s'associa a qualsevol conjunt. 
*/

Sovint, informalment, es defineix la dimensió com el nombre d'eixos de coordenades. Quan es tracta de determinar la dimensió d'un espai euclidià #footnote[El terme _espai euclidià_ es pot referir a un entorn $EE^3$ o $EE^n$ depenent del context.] $EE^n$, fer-ho és trivial: per definició, la seva dimensió és $n$, és a dir, el nombre de coordenades que hem de fer servir per localitzar qualsevol punt a l'espai. Però és més interessant trobar la dimensió dels propis objectes, que bé podem inserir en un espai. Per tant, com que el nombre d'eixos de coordenades és un valor de l'entorn i no del propi objecte, aquesta definició informal resulta ser poc útil. Com podem definir amb més precisió la dimensió per a qualsevol conjunt?

A les matemàtiques aquest terme té moltes definicions diferents, de vegades equivalents i altres no. En aquest capítol ens centrarem en la dimensió topològica i dues de les seves definicions.


/*
A la geometria fractal, és fonamental el concepte de _dimensió_. AquestaEn aquesta secció definirem amb rigor aquest terme, començant pels casos més simples amb la noció de dimensió comuna i acabant amb la dimensió fractal més utilitzada.


Utilitzem el terme _dimensió comuna_ per diferenciar el concepte usual de dimensió utilitzat en geometria bàsica i les diferents dimensions fractals. 
*/

=== Dimensió intrínseca



Anomenem dimensió intrínseca o paramètrica d'un objecte el nombre de paràmetres requerits per obtenir els punts que el formen (@def-dim-intrinseca).

#def[Dimensió intrínseca][
  Si $B$ és un conjunt i $P colon A -> B$ és la funció que retorna tots els punts de $B$, la _dimensió intrínseca_ de $B$ és el nombre mínim de variables independents necessàries.
] <def-dim-intrinseca>

Aleshores, per trobar la dimensió intrínseca, n'hi ha prou amb trobar una funció que defineixi els punts del conjunt. Per mostrar de forma senzilla aquest mètode, demostrem les dues proposicions següents:

#proposition[
  Una circumferència té dimensió 1.
] <prop-dim-circum>

#proposition[
  Un pla en $RR^3$ té dimensió 2.
] <prop-dim-pla>

#demo[de @prop-dim-circum][
  Aquesta proposició podria semblar contraintuïtiva, ja que no podem traçar una circumferència en $RR^1$ (i.e. en una línia contínua) però sí en $RR^2$ (i.e. el pla). Tanmateix, mitjançant la parametrització podem demostrar-ho.

  Podem trobar les coordenades d'una circumferència $c$ amb la seva equació paramètrica:

    
  $
  c#h(0%): cases(
    x = r cos(theta),
    y = r sin(theta)
  )
  $
  
  on $r$ és una constant que indica el radi de la circumferència. El paràmetre $theta$ és l'angle que forma el vector $accent(e_1, arrow)$ amb el vector $accent(O P, arrow)$.

  Hom pot trobar, aleshores, un punt $P$ que pertany a la circumferència $c$ només sabent el valor de l'angle $theta$ (recordem que el radi $r$ és una constant):
  
  $
  P(theta) = (x(theta), y(theta)) = (r cos(theta), r sin(theta))
  $
  
  Per tant, com només fa falta un sol paràmetre per obtenir els punts que formen la circumferència, aquest té dimensió 1.#footnote[Recordem que l'interior d'una circumferència no forma part d'ella. Quan ens referim a l'àrea d'una circumferència, llavors, realment estem parlant del seu interior. Això s'aplica a tota la resta de formes geomètriques bàsiques.]
]

#demo[de @prop-dim-pla][
  Aquesta proposició podria semblar òbvia, però demostrem-ho amb el mètode de la parametrització per il·lustrar millor el concepte de dimensió.

  Similarment a la demostració anterior, utilitzem l'equació paramètrica del pla $pi$ que s'estudia.
  
  Siguin $accent(O P, arrow) = (p_1, p_2, p_3)$ el vector posició d'un punt del pla i $accent(u, arrow) = (u_1, u_2, u_3)$ i $accent(v, arrow) = (v_1, v_2, v_3)$ vectors paral·lels al pla linealment independents. Aleshores, amb els paràmetres $lambda$ i $mu$, definim el pla:

  $
  pi#h(0%): cases(
    x = p_1 + lambda u_1 + mu v_1,
    y = p_2 + lambda u_2 + mu v_2,
    z = p_3 + lambda u_3 + mu v_3,
  )
  $

  de la qual obtenim una funció que retorni qualsevol punt del pla:

  $
  P(lambda, mu) = (p_1 + lambda u_1 + mu v_1, p_2 + lambda u_2 + mu v_2, p_3 + lambda u_3 + mu v_3) 
  $

  Per tant, com que podem expressar els punts del pla $pi$ amb dos paràmetres, l'objecte té dimensió 2. De nou, és interessant observar que, tot i que el pla es trobi en un entorn tridimensional, a $RR^3$, l'objecte en si té dimensió 2. Per reiterar-ho, si, hipotèticament, el pla estigués en un espai euclidià $EE^4$, aleshores tindríem quatre equacions enlloc de tres, però la dimensió seguiria sent 2.
]

Observeu com si haguéssim aplicat la definició informal amb "eixos de coordenades", erròniament hauríem associat la dimensió 2 a la circumferència i la dimensió 3 al pla. La dimensió és una propietat intrínseca de l'objecte, així que no pot dependre de l'entorn en què estigui inserit.


Ara, considerem una corba a $RR^2$. Una corba es pot deformar en una recta a $RR^1$, però, intuïtivament, no podem transformar una recta en un punt només deformant-lo (és a dir, sense tallar ni enganxar) perquè una recta té una llargada mentre que un punt no en té (@fig-homeomorfismes). Observeu com els dos primers objectes, la corba i la recta, són ambdós dimensió 2, però el punt té dimensió 1. Això fa pensar que si els objectes no tenen la mateixa dimensió, aleshores certes transformacions no són possibles. Aquestes deformacions s'anomenen _homeomorfismes_ (@def-homeomorfisme) i, per tant, la dimensió és una propietat topològica (@def-prop-topologica) perquè les transformacions homeomorfes  no alteren la dimensió de l'objecte. Per aquest motiu, el concepte de dimensió que s'ha exposat sol ser referit com a _dimensió topològica_.

#figure(caption: [Una corba en un pla es pot deformar en una recta, però cap dels dos en un punt. La primera transformació és un homeomorfisme i la segona no ho és.])[
  #canvas({
    import draw: *

    line((-3, 1.5), (4, 1.5), stroke: blue.lighten(60%))

    let transf = gray.lighten(50%)
    
    line((-3, 1.5), (-3, 1), stroke: transf)
    line((4, 2), (4, 1.5), stroke: transf)
    line((3, 2), (3, 1.5), stroke: transf)
    line((1, 1.5), (1, 1.2), stroke: transf)
    line((0, 1.5), (0, 0.85), stroke: transf)
    line((-1, 1.5), (-1, 0.75), stroke: transf)
    line((-2, 1.5), (-2, 0.8), stroke: transf)
    bezier-through((-3, 1), (3, 2), (4, 2))
    
    line((5, 1.5), (11, 1.5))

    circle((12,1.5), radius: 0.03, fill: black)
  })
] <fig-homeomorfismes>

/*
=== Dimensió per comportament local

La parametrització no és l'única definició de dimensió intrínseca. Un altre forma de trobar-la és estudiant el seu comportament local, que sovint és més fàcil de trobar que la parametrització en situacions una mica més complexes. Així, podem deduir intuïtivament que una circumferència és de dimensió 1
*/

=== Dimensió de recobriment de Lebesgue <cap-lebesgue-recobriment>

==== Explicació intuïtiva

Sovint, la parametrització resulta no ser un bon mètode fora de geometria euclidiana elemental. En aquesta secció exposarem una definició alternativa de la dimensió topològica.

Considerem l'interior d'un triangle i una corba. Clarament, el primer té dimensió 2 i el segon, 1 i, aleshores, el primer té superfície i el segon no (@fig-dim-lebesgue-1). Per expressar la dimensió topològica, tractem de trobar una altra forma d'expressar que un objecte té superfície o no.

#figure(caption: [Un triangle té superfície i una corba no.])[
  #canvas({
    import draw: *

    line((0,1), (4, 1), (2, 4), close: true, fill: gray.lighten(80%))

    bezier-through((5,1), (7, 3), (10, 2), )
  })
] <fig-dim-lebesgue-1>

Creem un recobriment obert a cada forma i ens fixem en els solapaments.

#figure(caption: [Exemple de recobriment amb tres conjunts per al triangle i dos per a la corba.])[
  #canvas({
    import draw: *

    line((0,1), (4, 1), (2, 4), close: true, fill: gray.lighten(80%))

    bezier-through((5,1), (7, 3), (10, 2), )

    let draw-set(..pts, color)=catmull(..pts, close: true, stroke: color, fill: color.transparentize(70%))

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
] <fig-dim-lebesgue-2>

Resulta que si maximitzem el nombre de conjunts que formen part dels recobriments i tractem de minimitzar el nombre de punts que es troben a més d'un conjunt, observem que, al triangle, tenim un màxim tres conjunts que contenen un mateix punt (@fig-dim-lebesgue-2) i, a la corba, dos. Això fa pensar que aquest nombre de solapaments està relacionat amb la dimensió topològica.

==== Definició formal

Aquesta altra definició de dimensió topològica s'anomena dimensió de recobriment de Lebesgue (@def-dim-lebesgue).

#def[Dimensió de recobriment de Lebesgue o dimensió topològica][
  Sigui $n$ un nombre enter tal que $n >= 1$. Diem que un conjunt $S$ té _dimensió de recobriment de Lebesgue_ $<= n$ si i només si cada recobriment obert de $S$ (@def-recobriment) té un refinament (@def-refinament) amb ordre de com a màxim $n$ (@def-ordre).

  Aleshores, clarament, el valor de la dimensió de recobriment de Lebesgue és $n$ si és $<= n$ però no $<= n-1$./*#footnote[La definició real fa servir refinaments, però l'autor no ha pogut arribar a entendre el seu propòsit i, segons ha pogut comprovar, l'ús directe dels recobriments no sembla afectar la definició.]*/ @Edgar1990
] <def-dim-lebesgue>

L'explicació detallada de la definició es troba a l'annex. Apliquem-la pas a pas demostrant les següents proposicions:

#proposition[Una corba té dimensió 1.] <prop-cim-corba>

#proposition[L'interior d'un triangle té dimensió 2.] <prop-dim-triangle>

#demo[de @prop-cim-corba][
  Adonem-nos que un recobriment d'una corba cobrirà tot la corba amb un sol conjunt o, si la col·lecció en té més d'un, per força tindrà algun solapament. Com hem observat a la @fig-dim-lebesgue-2,
]

/*

==== Teorema per a espais mètrics compactes

La dimensió de recobriment es pot calcular de forma més senzilla en espais mètrics compactes, cosa que serà útil per trobar el seu valor a les fractals estudiades a les següents seccions.- Recordem que un espai mètric compacte dins de $RR^n$ (@def-compacte) és un espai fitat i tancat.

#theorem[Teorema de la dimensió de recobriment de Lebesgue per a espais mètrics compactes][
  Siguin $S$ un espai mètric compacte i $n >= 1$ un enter. Si i només si per cada $epsilon > 0$ existeix un recobriment obert de $S$ (@def-recobriment) amb ordre $<= n$ (@def-ordre) i malla $<= epsilon$ (@def-malla).
]
*/

== Dimensió fractal <cap-dimensio-fractal>

Fins ara hem estudiat el concepte dimensió en formes bàsiques: corbes, circumferències, plans, rectes... Tanmateix, la dimensió topològica resulta ser insuficient per estudiar els objectes fractals, ja que molts dels seus resultats no donen informació sobre la seva estructura. Les dimensions fractals, en canvi, proveeixen informació sobre la rugositat de l'objecte. En aquesta secció s'estudiaran dues de les dimensions fractals i una situació comuna en què el càlcul d'aquests valors resulta ser més simple.

=== Dimensió de Hausdorff

==== Mesura de Lebesgue

Considerem el concepte bàsic de distància. Un espai euclidià és un espai mètric (@def-espai-mètric) $EE^n = (RR^n, d)$ on $d$ és la distància euclidiana (@def-mesura-distancia). Aleshores, a $EE^2$, $d(x, y) = sqrt((x_0 - y_0)^2 + (x_1 - y_1)^2 )$

Quan parlem de mesura de Lebesgue, és només una forma més elegant de referir-se a les mesures convencionals de llargada, àrea, volum, etc, per a $RR^1$, $RR^2$, $RR^3$, ..., $RR^n$#footnote[Evidentment, les definicions de dimensions no només s'apliquen a espais euclidians, però aquí només discutim aquests per simplificar l'explicació.]. És a dir, és una generalització del concepte de _llargada_ per a qualsevol dimensió $n$. Denotem $cal(L)^n$ com la mesura de Lebesgue a $RR^n$ (altres notacions en són $lambda^n$ o $"vol"^n$).

Considerem una corba $A$ en un pla, que és una varietat $RR^1$ a $RR^2$. La mesura de Lebesgue no ens permetria calcular la llargada d'aquesta corba: $cal(L)^2(A) = 0$ perquè $cal(L)^2$ és l'àrea i una corba no en té, i $cal(L^1)(A)$ no existeix perquè $cal(L)^n$ només funciona per a subconjunts de $RR^n$. En general, la mesura de Lebesgue no és convenient quan tenim un subconjunt $m$-dimensional de $RR^n$ amb $m < n$ @morgan-measures.

#figure(caption: [Una corba no té àrea, però la llargada tampoc es pot calcular amb la mesura de Lebesgue.])[
  #canvas({
    import draw: *


    bezier-through((3,1), (6, 2), (10, 1), )
  })
]

/*
#figure(
canvas(length: 3cm, {
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

  grid((-1.25, -1.25), (1.25, 1.25), step: 0.25, stroke: gray + 0.2pt)


  line((-1.25, 0), (1.25, 0), mark: (end: "stealth"))
  line((0, -1.25), (0, 1.25), mark: (end: "stealth"))
})
)
*/

==== Mesura de Hausdorff


La mesura de Hausdorff ve motivada per calcular la _llargada_ (és clar, de forma genèrica per a qualsevol dimensió) de qualsevol subconjunt d'un espai mètric, evitant els problemes que causa la mesura de Lebesgue. Consisteix en realitzar recobriments amb un diàmetre dels conjunts (@def-recobriment-delta) cada vegada més petit, de manera que quan siguin infinitament petits i, per tant, el recobriment estigui format per un nombre infinit de conjunts, podrem obtenir la llargada $s$-dimensional del conjunt (@fig-dim-hausdorff).

#figure(caption: [Visualització del funcionament de la mesura de Hausdorff per a una corba en un pla. Els diàmetres dels conjunts (en blau) es fan cada vegada més petits, obtenint un valor cada vegada més precís de la llargada del conjunt en qüestió (en negre).])[
  #canvas({
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
  })
] <fig-dim-hausdorff>

#def[Mesura de Hausdorff][
  Definim la _mesura de Hausdorff_ $s$-dimensional com la suma més petita possible de diàmetres elevats a $s$ dels conjunts que formen una cobertura-$delta$, amb $delta$ tendint a zero. Simbòlicament:

  $ hausdorff = lim_(delta -> 0)  inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
$
] <def-mesura-hausdorff>



La justificació de la definició formal està explicada amb summe detall a l'annex corresponent.

/*
#theorem[Relació entre la mesura de Lebesgue i la mesura de Hausdorff][ Donat un conjunt $A$ $n$-dimensional tal que $A subset RR^n$ i la mesura de Hausdorff $n$-dimensional del conjunt $A$ on $n$ és un nombre enter positiu, la mesura de Hausdorff i la mesura de Lebesgue segueixen la relació
  
  $
  cal(H)^n (A) = c_n^(-1) cal(L)^n (A)
  $
  
  on $c_n$ és el volum d'una $n$-esfera de diàmetre 1, que es calcula amb l'expressió
  
  $
  c_n = pi^(n/2) / Gamma(n/2 + 1)
  $
  
  on $Gamma$ és la funció gamma (@funcio-gamma). /*A més, desenvolupant aquesta funció, podem obtenir expressions equivalents més simples segons la paritat de $n$ per facilitar el càlcul @falconer-unit-ball:
  
  $
  c_n = cases(
    display(
      pi^(n/2)/(n/2)!
    ) &n eq.triple 0" "(mod 2),
    display(
      display(pi^((n-1)/2) ((n-1)/2)! ) / n!
    ) wide&n eq.triple 1" "(mod 2)
  )
  $*/
]
*/


/*

Considerem de nou l'@eq-hausdorff-delta. Observem que si $delta < 1$, #hausdorffdelta decreix o no augmenta amb $s$. És a dir, que per $s < t$ i $delta < 1$, necessàriament es compleix que:

$
cal(H)^s_delta (A) >= cal(H)^t_delta (A) 
$

I com @eq-hausdorff és el límit amb $delta -> 0$, similarment:
*/

==== Definició de la dimensió de Hausdorff

Resulta que la mesura de Hausdorff compleix les següents proposicions, la demostració dels quals es troba a l'annex:

#proposition[
  Si $cal(H)^s (A) > 0$ i $s < t$, aleshores $cal(H)^t (A) = +infinity$.
  
] <hausdorff-prop1>

#proposition[
  Si $cal(H)^t (A) < +infinity$ i $s < t$, aleshores $cal(H)^s (A) = 0$.
  
] <hausdorff-prop2>

Intuïtivament, aquestes proposicions haurien de semblar raonables; de la mateixa manera que la mesura de Lebesgue $n$-dimensional només s'aplica a conjunts $n$-dimensionals en $RR^n$ ---ja que no tindria sentit intentar mesurar la llargada pròpiament dita d'un cub, o el volum d'una recta---, la mesura de Hausdorff també és només finita per a un valor específic de dimensió. 

Aquestes proposicions impliquen que la mesura de Hausdorff $s$-dimensional és o bé $+infinity$ per a valors petits de $s$ o bé 0 per a s valors grans de $s$, excepte un valor específic. Aquest valor de $s$ és la dimensió de Hausdorff. Per tant, podem definir-la així:

$
dim_"H " A = inf{s : hausdorff = 0} = sup{s : hausdorff = +infinity}
$

El fet sorprenent de la mesura de Hausdorff, que marca la diferència amb la mesura de Lebesgue, tanmateix, és que aquest valor $s$, la dimensió de Hausdorff, per definició, pot no ser un enter.

=== Dimensió autosimilar //p. 118



=== Condició del conjunt obert

== Fractals de sistemes de funcions iterades

=== Definició
//Aquests tipus de fractals també s'anomenen Sistemes de Funcions Iterades, o _IFS_ per abreviar.


=== Triangle i catifa de Sierpinski

==== Construcció


==== Càlcul de la dimensió topològica

#proposition[El triangle de Sierpinski té dimensió topològica 1.] <prop-sierpinski-dim>

#demo[de @prop-sierpinski-dim][
  
]
El conjunt $S_0$ està, lògicament, format per un sol triangle equilàter de costat 1. El conjunt $S_1$ està format per tres conjunts $S_0$ cadascun de costat $1/2$. Com que de cada triangle n'apareixen tres a la següent iteració, inductivament, deduïm que el conjunt $S_k$ conté $3^k$ triangles de costat $2^(-k)$ cadascun.


=== Conjunts de Cantor <cap-cantor>

Hi ha múltiples conjunts de Cantor, però aquí

==== Definició geomètrica

El conjunt triàdic de Cantor es defineix en $RR^1$ a partir del segment $[0,1]$. Anomenarem aquest punt de partida $C_0$. $C_1$ es construeix eliminant el segon terç del segment, obtenint $C_1 = [0, 1 slash 3] union [2 slash 3, 1]$. En general, $C_(k+1)$ és el resultat d'eliminar el segon terç de cadascun dels segments de què $C_k$ està format. Aleshores, el conjunt de Cantor es defineix com $C = lim_(n->+infinity) C_n$.

#figure(caption: [Primeres cinc iteracions del conjunt de Cantor])[
  #canvas({
    import draw: *

    
    
    
  })
]

==== Definició aritmètica

==== Propietats

=== Estel de Koch

== Fractals de funcions sobre el pla

=== Conjunts de Julia

/*p. 27*/
#figure(caption: [])[
  #canvas({    
    import draw: *

    let c = ()

    let julia
    
    line((0,1), (4, 1), (2, 4), close: true, fill: gray.lighten(80%))

    bezier-through((5,1), (7, 3), (10, 2), )
  })
]

=== Conjunt de Mandelbrot

=== Fractal de Newton
/*
== Atractors estranys
=== Teoria del caos

=== Atractor de Lorentz

== Fractals tridimensionals
Quaternions

*/
