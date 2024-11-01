#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "../geo.typ": *
#import "../figures.typ"
#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/cetz:0.2.2": canvas, draw, plot

= Estudi matemàtic dels objectes fractals

En aquesta part del treball, s'exposaran les matemàtiques que estudien els objectes fractals. La primera secció introdueix el concepte de dimensió topològica, que contextualitza la següent secció, que tracta la dimensió fractal. La segona i tercera secció estudien els exemples més coneguts dels dos grans tipus de fractals: els sistemes de funcions iterades i els conjunts de Julia.

A continuació, es presenten les definicions matemàtiques utilitzades en aquest capítol. Per motius de brevetat, algunes definicions conegudes al currículum de Batxillerat com la continuïtat d'una funció no s'han exposat. S'assumeix, també, un coneixement bàsic de teoria de conjunts. /*En un intent de simplificar les definicions, s'ha optat per no fer ús del terme _espai mètric_ i utilitzar més simplement el terme _conjunt_. Per aquest motiu, cal tenir en compte que sempre que es faci servir aquest últim terme, la definició és vàlida per a qualsevol espai mètric.*/


#def[Topologia sobre un conjunt][
  Una _topologia_ $tau$ sobre un conjunt $X$ és una col·lecció de subconjunts oberts de $X$ tals que el conjunt buit i $X$ mateix estan en $tau$ i es compleix que tant la intersecció com la unió dels conjunts de cada subcol·lecció finita de $tau$ està dins $tau$. Simbòlicament:

  $
  emptyset in tau, X in tau \
  forall S in tau, union.big_(O in S) O in T and sect.big_(O in S) O in T
  $

  La _topologia discreta_ és la col·lecció de tots els subconjunts de $X$ i la _topologia indiscreta_ és simplement el conjunt buit i $X$.
  
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
  Donada una col·lecció de conjunts $cal(F)$ en un espai mètric $(M, d)$ (@def-espai-mètric), el seu _ordre_ és el major nombre de conjunts que se superposen en un sol punt. Formalment, l'ordre és l'enter més petit $k$ tal que cap punt en $M$ pertany a més de $k+1$ conjunts en $cal(F)$ a la vegada.

  on l'operador $abs(Y)$ indica la cardinalitat del conjunt, és a dir, el nombre d'elements.
] <def-ordre>


#def[Refinament][
  Donat un recobriment $cal(C)$ (@def-recobriment) d'un espai topològic $(M, d)$ un _refinament_ és un altre conjunt $cal(R)$ cada $R_j in cal(R)$ és un subconjunt d'algun $C_i in cal(C)$.
  
  Intuïtivament, un refinament és un segon recobriment format per conjunts més petits que el primer recobriment.
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

A les matemàtiques aquest terme té moltes definicions diferents, de vegades equivalents i altres no. En aquest capítol ens centrarem en la dimensió topològica i dues de les seves definicions equivalents.


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
  Sigui $n$ un nombre enter tal que $n >= -1$. Diem que un conjunt $S$ té _dimensió de recobriment de Lebesgue_ $<= n$ si i només si cada recobriment obert de $S$ (@def-recobriment) té un refinament (@def-refinament) amb ordre de com a màxim $n$ (@def-ordre).

  Aleshores, clarament, el valor de la dimensió de recobriment de Lebesgue és $n$ si és $<= n$ però no $<= n-1$/*#footnote[La definició real fa servir refinaments, però l'autor no ha pogut arribar a entendre el seu propòsit i, segons ha pogut comprovar, l'ús directe dels recobriments no sembla afectar la definició.]*/ @Edgar1990.
] <def-dim-lebesgue>

Apliquem-la pas a pas demostrant la següent proposició: //les següents proposicions:

#proposition[Una corba té dimensió 1.] <prop-dim-corba>
/*
#proposition[L'interior d'un triangle té dimensió 2.] <prop-dim-triangle>*/

#demo[de @prop-dim-corba][
  Adonem-nos que un recobriment d'una corba cobrirà tot la corba amb un sol conjunt o, si la col·lecció en té més d'un, per força tindrà algun solapament. Com hem observat a la @fig-dim-lebesgue-2, si hi ha més d'un conjunt, aleshores hi haurà un solapament entre dos conjunts.

  Per aplicar correctament la definició, classifiquem els recobriments possibles en dos classes: (i) recobriments amb un conjunt i (ii) recobriments amb dos o més conjunts. Els recobriments de classe (i) són d'ordre 0 i els de classe (ii) són d'ordre 1 o més.
  
  El refinament de la classe (i) de conjunts pot ser un recobriment de (i) o (ii) i el refinament de classe (ii) sempre seran (ii) perquè tots els conjunts del refinament han de ser subconjunt d'algun conjunt del recobriment, de manera que sempre poden ser refinats per ser d'ordre 1.

  Descartem la dimensió $-1$ perquè només s'aplica al conjunt buit. Si la dimensió és $<= 0$, aleshores tots els recobriments oberts han de tenir un refinament d'ordre 0, però això no és així perquè els de classe (ii) són per força d'ordre 1. Clarament, pel raonament anterior, la dimensió sí que es compleix que és $<=1$ i com que busquem el valor més petit, la el valor de la dimensió de recobriment d'una corba és 1.
]

Similarment a aquesta demostració, hom pot mostrar que l'interior d'un triangle té dimensió de recobriment 2. L'autor ho proposa com un exercici per al lector.
/*
De la demostració anterior,

#demo[de @prop-dim-triangle][
  
]
*/

/*

==== Teorema per a espais mètrics compactes

La dimensió de recobriment es pot calcular de forma més senzilla en espais mètrics compactes, cosa que serà útil per trobar el seu valor a les fractals estudiades a les següents seccions.- Recordem que un espai mètric compacte dins de $RR^n$ (@def-compacte) és un espai fitat i tancat.

#theorem[Teorema de la dimensió de recobriment de Lebesgue per a espais mètrics compactes][
  Siguin $S$ un espai mètric compacte i $n >= 1$ un enter. Si i només si per cada $epsilon > 0$ existeix un recobriment obert de $S$ (@def-recobriment) amb ordre $<= n$ (@def-ordre) i malla $<= epsilon$ (@def-malla).
]
*/

== Dimensió fractal <cap-dimensio-fractal>

Fins ara hem estudiat el concepte dimensió en formes bàsiques: corbes, circumferències, plans, rectes... Tanmateix, la dimensió topològica resulta ser insuficient per estudiar els objectes fractals, ja que molts dels seus resultats no donen informació sobre la seva estructura. Les dimensions fractals, en canvi, proveeixen informació sobre la rugositat de l'objecte. De fet, com s'estudiarà a capítols posteriors, es pot deduir que molts objectes fractals han de tenir per força una dimensió topològica fraccionària, però les definicions exposades fins ara no ho permeten. En aquesta secció s'estudiaran dues de les dimensions fractals més utilitzades i una situació comuna en què el càlcul d'aquests valors resulta ser més simple.

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


La mesura de Hausdorff ve motivada per calcular la _llargada_ (és clar, de forma genèrica per a qualsevol dimensió) de qualsevol subconjunt d'un espai mètric, evitant els problemes que causa la mesura de Lebesgue. Consisteix en realitzar recobriments amb un diàmetre dels conjunts (@def-recobriment-delta) cada vegada més petits, de manera que quan siguin infinitament petits i, per tant, el recobriment estigui format per un nombre infinit de conjunts, podrem obtenir la llargada $s$-dimensional del conjunt (@fig-dim-hausdorff). La mesura de Hausdorff és invariant a la forma d'aquests conjunts, ja que el seu diàmetre tendeix a zero.

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



La justificació de la definició formal està explicada amb summe detall a l'annex corresponent (@expl-mesura-hausdorff).

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

La dimensió de Hausdorff es basa en el @teorema-dim-hausdorff.

#theorem[Teorema de la dimensió de Hausdorff][
  Donat un conjunt $A$, existeix un únic valor $s$ tal que $cal(H)^s (A)$ és finit i no nul.
] <teorema-dim-hausdorff>

#demo[de @teorema-dim-hausdorff][
  Considerem la funció $f(s) = cal(H)^s (A)$. $f$ és nul·la per valors petits de $s$, després finita no nul·la per un valor concret de $s$ i infinita per la resta de valors de $s$. Expressem aquest comportament amb desigualtats per demostrar-lo rigorosament (@hausdorff-prop1, @hausdorff-prop2#footnote[Aquí es fa servir el terme "lema" perquè aquestes proposicions només són útils en el context d'aquesta demostració.])

  #lemma[
    Si $cal(H)^s (A) > 0$ i $s < t$, aleshores $cal(H)^t (A) = +infinity$. És a dir, si la mesura de Hausdorff és no nul·la per a alguna dimensió, aleshores la mesura per a qualsevol dimensió superior serà infinita.
    
  ] <hausdorff-prop1>
  
  #lemma[
    Si $cal(H)^t (A) < +infinity$ i $s < t$, aleshores $cal(H)^s (A) = 0$. És a dir, si la mesura de Hausdorff és finita per a alguna dimensió, aleshores la mesura per a qualsevol dimensió inferior serà nul·la.
    
  ] <hausdorff-prop2>

  Les demostracions d'ambdós lemes s'exposen als annexos.

  Deduïm, aleshores, que el valor no nul $s$ és únic i per tant el teorema és cert.


]



Intuïtivament, aquestes proposicions haurien de semblar raonables; de la mateixa manera que la mesura de Lebesgue $n$-dimensional només s'aplica a conjunts $n$-dimensionals en $RR^n$ ---ja que no tindria sentit intentar mesurar la llargada pròpiament dita d'un cub, o el volum d'una recta---, la mesura de Hausdorff també és només finita per a un valor específic de dimensió. 

 Aquest valor de $s$ és la dimensió de Hausdorff. Per tant, formalment, podem definir-la així:

$
dim_"H " A = inf{s >= 0 : hausdorff = 0} = sup{s >= 0 : hausdorff = +infinity}
$

==== Relació amb la dimensió topològica

La dimensió de recobriment de Lebesgue coincideix amb la dimensió de Hausdorff en conjunts, informalment parlant, "regulars" o que es "comporten bé", és a dir, que no tenen cap complexitat geomètrica. Quan el conjunt és una fractal la dimensió de Hausdorff sol no ser un enter i, aleshores, no coincideix.

#theorem[Relació entre la dimensió de Hausdorff i la dimensió topològica][Un conjunt de dimensió topològica $n$ té una dimensió#footnote[La versió en paper incorrectament diu "mesura".] de Hausdorff de $n$ on $n$ és un nombre enter.] <teorema-hausdorff-topologica>
/*
La demostració del teorema està disponible als annexos.
*/

=== Dimensió auto-similar <cap-dim-autosimilar>

La _dimensió auto-similar_ és una altra dimensió fractal que és més fàcil de definir i d'aplicar. Es basa en un teorema (@teorema-dim-autosimilar) a partir dels sistemes de funcions iterades, que s'exposa més tard (@cap-ifs-def).#footnote[És molt recomanable llegir la secció corresponent sobre els IFS abans de seguir amb la dimensió auto-similar i la condició del conjunt obert.]


#theorem[Teorema de la dimensió auto-similar][
  Sigui la llista de ràtios $(r_1, r_2, ..., r_n)$ amb $n>=1$. Si cada $r_i < 1$, aleshores existeix un únic $s$ no negatiu tal que $sum^n_(i=1) r_i^s = 1$.
] <teorema-dim-autosimilar>

La demostració d'aquest teorema està disponible als annexos.

#proposition[Un cuboide rectangular de costats $a, b,c$ és de dimensió auto-similar 3.] <prop-dim-rectangle>

#demo[de @prop-dim-rectangle][
  Un cuboide es pot partir en 8 cuboides iguals cadascun amb la meitat de costat que el cuboide principal.

  #figure(caption: [Representació d'un cuboide rectangular i la seva partició en vuit formes similars.],
  {
   figures.cuboids(5, 2.5, 3)
  })

  Per tant, la ràtio per a totes les particions és $1 slash 2$. S'ha de complir que

  $
  sum^n_(i=1) r_i^s = 1
  $

  Com que totes les $r_i$ són $1slash 2$ i $n = 8$, tenim que

  $
  n r_i^s = 1 => 8 (1/2)^s = 1 <=> (1 / 2)^s = 1 / 8 <=> 1 / 2^s = 1/8 <=> s = 3
  $

  Per tant, la dimensió auto-similar d'un cuboide rectangular és 3.
]

=== Condició del conjunt obert

La _condició del conjunt obert_ és una situació possible que es pot donar en un sistema de funcions iterades, que s'exposen al capítol següent.

#def[Condició del conjunt obert][
  Un sistema de funcions iterades $(f_1, f_2, ..., f_n)$ (@cap-ifs-def), compleix la _condició del conjunt obert_ si i només si existeix un conjunt obert $U$ tal que cada parella de funcions tingui una intersecció buida i que cada funció estigui inclosa en $U$. 
  
  Simbòlicament,
  
  $ (f_i [U] sect f_j [U] = emptyset med forall i,j : i != j) and (f_i [U] subset.eq U med forall i) $
] <def-condicio-conjunt-obert>

Els sistemes que compleixen la @def-condicio-conjunt-obert tenen una propietat molt important (@teorema-condicio-conj-obert).

#theorem[Teorema de la dimensió amb la condició del conjunt obert][
  Si un sistema de funcions iterades $(f_1, f_2, ..., f_n)$, compleix la condició del conjunt obert, aleshores la seva dimensió de Hausdorff i dimensió auto-similar són iguals.
] <teorema-condicio-conj-obert>

La demostració d'aquest teorema és molt més complexa de què l'autor és capaç de mostrar en aquest treball.

La majoria de fractals compleixen la condició del conjunt obert, és a dir, tenen una dimensió de Hausdorff i una dimensió auto-similar igual, per la qual cosa el mètode més senzill per calcular la dimensió fractal és trobar primer aquesta última, ja que és més fàcil.

Al següent capítol s'aplicarà aquesta propietat per calcular les dimensions auto-similar i de Hausdorff de les fractals proposades.


== Fractals de sistemes de funcions iterades <cap-ifs>

=== Els sistemes de funcions iterades <cap-ifs-def>

==== Definició general 

Els sistemes de funcions iterades són una forma d'expressar l'autosimilitud d'un objecte geomètric mitjançant funcions recursives que tenen com a entrada un conjunt. Definir el sistema per a una fractal és útil per calcular la seva dimensió.

Recordem que la notació $A' = f[A]$ expressa una transformació $f$ d'un conjunt $A$ a un conjunt $A'$. És equivalent a $A' = {f(x_0) : x_0 in A}$. Es compleix que $f[A union B] = f[A] union f[B]$.

Definim una _llista de proporcions_ com una $n$-tupla de nombres positius $(r_1,r_2, ..., r_n)$. Un _sistema de funcions iterades_ (IFS, de l'anglès _iterated function systems_) sobre una llista de proporcions en un espai mètric $M$ (@def-espai-mètric) és una $n$-tupla $(f_1, f_2, ..., f_n)$ on $f_i colon S -> S$ és una funció que transforma un conjunt en $S$ de manera que el conjunt que retorna té una semblança respecte el d'entrada de $r_i$. Les proporcions són lineals, és a dir, la semblança és de llargada.

==== Definició vectorial

Si la transformació és similar (només es mou, es rota o es canvia la mida del conjunt en qüestió), les funcions de transformació  $f_i colon RR^d -> RR^d$ es poden definir així:

$
f_i (arr(x)) = r U arr(x) + arr(b), wide r in (0, 1),
$

on $arr(x)$ és el vector posició del punt $x$, $U$ és una matriu unitària (e.g. una rotació o reflexió), $r$ és la proporció i $arr(b)$ és un vector de translació. La matriu unitària $U$, per exemple, podria ser una rotació:

$
R_theta = mat(
  cos(theta), -sin(theta);
  sin(theta), cos(theta)
)
$


A l'#pritable-doclink(<expl-matrius>) s'exposa la motivació de fer servir matrius i vectors en geometria analítica.

==== Atractor
Diem que un conjunt compacte $K subset.eq S$ és un _atractor_ pel sistema de funcions iterades si i només si es compleix la recursivitat $K = union.big_(i=1)^n f_i [K]$, on $n$ és el nombre de funcions en el sistema. 

==== Dimensió auto-similar

La dimensió auto-similar (@cap-dim-autosimilar), que recordem que és el nombre positiu $s$ tal que $sum^n_(i=1) r_i^s = 1$ , també rep el nom de _valor de similitud_. Totes les fractals que s'estudiaran a continuació compleixen la condició del conjunt obert (@def-condicio-conjunt-obert), així que pel @teorema-condicio-conj-obert el valor de similitud i la dimensió de Hausdorff seran iguals. Ens referirem en general a aquest valor com dimensió fractal.

=== Conjunt de Cantor <cap-cantor>

Hi ha múltiples conjunts de Cantor, però aquí només ens fixarem en el _pols triàdic de Cantor_.

==== Construcció geomètrica

El conjunt triàdic de Cantor es defineix en $RR^1$ a partir del segment $[0,1]$. Anomenarem aquest punt de partida $C_0$. $C_1$ es construeix eliminant el segon terç del segment, obtenint $C_1 = [0, 1 slash 3] union [2 slash 3, 1]$. En general, $C_(k+1)$ és el resultat d'eliminar el segon terç de cadascun dels segments de què $C_k$ està format. Aleshores, el conjunt de Cantor es defineix com $C = lim_(n->+infinity) C_n$.

#figure(caption: [Primeres set iteracions del conjunt de Cantor])[
  #figures.cantor(7)
] <fig-cantor>

Observeu com cada punt d'inici i final dels conjunts de cada iteració sempre formen part del conjunt de Cantor. Si el segment inicial és de longitud $1$, la longitud dels segments en la iteració $k$ és $3^(-k)$.

==== Construcció amb IFS

#proposition[Conjunt de Cantor per IFS][
  Siguin $f_1$ i $f_2$ les dues funcions del sistema:
  
  $
  f_1(x) = 1 / 3 x, f_2(x) = 1/3 x + 2/3
  $

  Aleshores, el pols triàdic de Cantor està definit pel conjunt

  $
  C = f_1 [C] union f_2 [C]
  $

  amb la llista de similitud $(1 slash 3, 1 slash 3)$
] <prop-cantor-def>

La demostració de la @prop-cantor-def es troba a l'annex corresponent.


/*
#demo[de @prop-def-cantor][
  La demostració rigorosa és més llarga però aquí ho simplificarem.

  
]*/

==== Càlcul de la dimensió topològica

#proposition[El pols triàdic de Cantor té dimensió topològica 0.] <prop-cantor-dim-top>

#demo[de @prop-cantor-dim-top][
  A cada iteració, s'elimina un terç de la llargada. Per tant, la llargada a cada iteració és $display((2/3)^k)$. Com que el límit a infinit d'aquesta expressió és 0, la dimensió topològica no es correspon a la d'una recta, així que serà menor que 1.

  Per tant, la dimensió topològica només pot ser 0, perquè -1 està associat al conjunt buit.
]

==== Càlcul de la dimensió fractal

#proposition[El pols triàdic de Cantor té dimensió fractal $log 2 slash log 3$] <prop-cantor-dim-frac>

#demo[de @prop-cantor-dim-frac][
  Busquem la dimensió auto-similar. La llista de proporcions és $(1 slash 3, 1 slash 3)$, ja que per cada segment es mantenen els dos terços dels costats a cada iteració. Per tant:

  $
  sum^n_(i=1) r_i^s = 1 \
  2(1/3)^s = 1 <=> (1/3)^s = 1/ 2 <=> 3^s = 2 <=> s = log_3 2 = (log 2)/(log 3) approx "0,6309" #qedhere
  $

  
]


=== Triangle de Sierpinski

==== Construcció geomètrica

El triangle de Sierpinski es construeix començant amb un triangle equilàter amb el seu interior, que anomenarem $S_0$. Per a cada $S_k$, partim el triangle equilàter en quatre triangles semblants i eliminem l'àrea del triangle central. El procés segueix recursivament per a cada triangle ple.

#figure(caption: [Primeres sis iteracions del triangle de Sierpinski.])[
  #figures.sierpinski(6)
] <fig-sierpinski>

A la iteració $k$ tenim $3^k$ triangles i a cada pas s'elimina $1 slash 4$ de l'àrea del triangle.

==== Construcció amb IFS

#proposition[Triangle de Sierpinski per IFS][
  Donat un punt $c$ en el pla i un nombre real $r >0$, definim una _dilació_ amb centre $c$ i ràtio $r$ com una transformació $f$ de manera que la distància des de $f(x)$ fins a $c$ és $r$ vegades la distància de $x$ a $c$. Tots els punts $c$, $x$ i $f(x)$ estan alineats.

  Definim el triangle de Sierpinski amb el sistema de funcions iterades $(f_1, f_2, f_3)$, on cada funció és una dilació en el pla sent els centres cada vèrtex d'un triangle equilàter i les ràtios totes $1 slash 2$. Per tant, la llista de similitud és $(1 slash 2, 1 slash 2, 1 slash 2)$ i es defineix el triangle de Sierpinski amb la recursivitat
  
  $
  S = f_1 [S] union f_2 [S] union f_3 [S] 
  $

] <prop-def-sierpinski>

La demostració de la @prop-def-sierpinski és trivial i no s'exposarà.


==== Càlcul de la dimensió topològica

#proposition[El triangle de Sierpinski té dimensió topològica menor que 2.] <prop-sierpinski-dim-top-menor-2>

#proposition[El triangle de Sierpinski té dimensió topològica 1.] <prop-sierpinski-dim-top-1> 

La demostració d'ambdues proposicions es troba als annexos.

==== Càlcul de la dimensió fractal

#proposition[El triangle de Sierpinski té dimensió fractal $log 3 slash log 2$] <prop-sierpinski-dim-frac>

#demo[de @prop-sierpinski-dim-frac][
  Busquem la dimensió auto-similar. La llista de proporcions és $(1 slash 2, 1 slash 2, 1 slash 2)$, ja que el costat es divideix per la meitat a cada iteració. Per tant:

  $
  sum^n_(i=1) r_i^s = 1 \
  3(1/2)^s = 1 <=> (1/2)^s = 1/ 3 <=> 2^s = 3 <=> s = log_2 3 = (log 3)/(log 2) approx "1,585" #qedhere
  $
  
]


=== Corba de Koch <cap-corba-koch>

==== Construcció geomètrica

La corba de Koch comença amb un segment que es divideix en tres segments de llargada $c$. Es construeix un triangle equilàter sobre el segment principal tal que el segment del mig n'és la base; els segments de l'esquerra i la dreta es deixen tal qual. Aleshores, per cada segment de la forma resultant, es segueix el procés recursivament. 

#figure(caption: [Cinquena iteració de la corba de Koch.])[
  #figures.koch(5, only-one: true)
]

Als annexos es troba una figura més gran amb sis iteracions (@fig-koch-iteracions).

/*
******

Més d'una hora m'he passat escrivint tot això, per adonar-me que podia simplement utilitzar l'angle del triangle equilàter.

I am in Spain but the s is silent.

*****


Denotem un vector fix que actualment forma part de la corba en negreta. 

Considerem que la corba de Koch es construeix entre els punts $A = (0, 0), B = (1, 0)$. El vector entre aquests dos punts $bold(arr(A B)) = (0, 1)$. Siguin $P, Q$ tal que $ arrow(O P) = arrow(O A) + 1/3 arrow(A B), wide arrow(O Q) = arrow(O A) + 2/3 arrow(A B) $

$arrow(O P)$ i $arrow(O Q)$ són els vectors posició dels punts que delimiten les tres parts en què es divideix el vector $arr(A B)$.
/*
$
arrow(O P) = (0, 0) + 1/ 3 (0, 1) =(0, 1/ 3) => P = (0, 1/3) \
arrow(O Q) =(0, 0) + 2/ 3 (0, 1) = (0, 2/3) => Q = (0, 2/3) \
$

Calculem els vectors $arrow(A P)$ i $arrow(Q B)$:

$
arrow(A P) =
$
*/

Aleshores, eliminem el vector $arrow(P Q)$ de la corba, quedant-nos els vectors $bold(arrow(A P))$ i $bold(arrow(Q B))$.

Ara, hem de construir el triangle $triangle P Q T$, on $T$ és l'altre vèrtex del triangle. Sigui $M$ el punt mig del vector $arr(P Q)$ (i també del vector $arr(A B)$). Aleshores, els vectors $arr(M T)$ i $arr(P Q)$ són perpendiculars. Per tant, el seu producte escalar serà nul i, com que estem en la base canònica de $RR^2$, en podrem deduir les coordenades del punt $T$:

$
arr(M T) = (t_1 - m_1, t_2 - m_2), wide arr(P Q) = (q_1 - p_1, q_2 - p_2) \
arr(M T) dot arr(P Q) = (t_1 - m_1)(q_1 - p_1) + (t_2 - m_2)(q_2 - p_2) = 0 <=> \
<=> t_1 (q_1 - p_1) - m_1 q_1 + m_1 p_1 + t_2 (q_2 - p_2) -m_2 q_2 + m_2 p_2 = 0
$

Coneixem totes les variables excepte $t_1$ i $t_2$. Busquem una altra equació per formar un sistema.

Hem de tenir en compte la llargada dels costats. La llargada dels costats és $abs(arr(P Q)) = abs(arr(P T))$:

$
abs(arr(P Q)) =sqrt((q_1 - p_1)^2 +(q_2 - p_2)^2) \
abs(arr(P T)) =sqrt((t_1 - p_1)^2 +(t_2 - p_2)^2) \
$
$
abs(arr(P Q)) &= abs(arr(P T)) \
sqrt((q_1 - p_1)^2 +(q_2 - p_2)^2) &=^((*)) sqrt((t_1 - p_1)^2 +(t_2 - p_2)^2) \
(q_1 - p_1)^2 +(q_2 - p_2)^2 &= (t_1 - p_1)^2 +(t_2 - p_2)^2 \
(q_1 - p_1)^2 +(q_2 - p_2)^2 &= t_1^2 - 2t_1p_1 + p_1^2 + t_2^2 - 2t_2p_2 + p_2^2 \
$
$
t_1^2 - 2t_1p_1 + p_1^2 + t_2^2 - 2t_2p_2 + p_2^2 - (q_1 - p_1)^2 - (q_2 - p_2)^2 = 0
$

(\*) Les arrels es poden eliminar perquè és segur que dins d'elles sempre hi haurà un nombre positiu.

Això resulta en el següent sistema

$
cases(
  t_1^2 - 2t_1p_1 + p_1^2 + t_2^2 - 2t_2p_2 + p_2^2 - (q_1 - p_1)^2 - (q_2 - p_2)^2 = 0,
  t_1 (q_1 - p_1) + m_1( p_1 - q_1)  + t_2 (q_2 - p_2) + m_2(p_2 -q_2) = 0
)
$

Perquè tot sigui en termes de $p_i$ i $q_i$, podem substituir que $m_1 = (p_1 + q_1)/2, m_2=(p_2 + q_2)/2$:

$
cases(
  t_1^2 - 2t_1p_1 + p_1^2 + t_2^2 - 2t_2p_2 + p_2^2 - (q_1 - p_1)^2 - (q_2 - p_2)^2 = 0,
  t_1 (q_1 - p_1) + 1/2 (p_1 + q_1)( p_1 - q_1)  + t_2 (q_2 - p_2) +  1 / 2 (p_2 + q_2)(p_2 -q_2) = 0
)
$

Comprovem el sistema amb el segment inicial representat pel vector $arr(A B) = (0, 1)$, amb $A = (0,0), B = (1, 0)$. Per tant, 

$
arrow(O P) = (0, 0) + 1/ 3 (1, 0) =( 1/ 3, 0) => P = ( 1/ 3, 0) => p_1 = 1/3, p_2 =0\
arrow(O Q) =(0, 0) + 2/ 3 (1, 0) = (2/3, 0) => Q = (2/3, 0) => q_1 = 2/3, q_2 = 0 \
$

Substituïm al sistema, eliminant tot allò que multipliqui $p_2$ o $q_2$, ja que són valors nuls. Comencem amb la segona equació:

$
t_1 (q_1 - p_1) + 1/2 (p_1 + q_1)( p_1 - q_1))  + cancel(t_2 (q_2 - p_2)) +  cancel(1 / 2 (p_2 + q_2)(p_2 -q_2)) &= 0 \
t_1 (q_1 - p_1) + 1/2 (p_1 + q_1)( p_1 - q_1)) &= 0 \
t_1 (2/ 3 - 1/ 3) + 1 / 2 (1 / 3 + 2 / 3)(1 / 3 - 2 / 3) &= 0 \
t_1 dot 1 / 3 - 1 / 6 &=0 \
t_1 &= 1 / 2

$

Substituïm a la primera:

$
t_1^2 - 2t_1p_1 + p_1^2 + t_2^2 - cancel(2t_2p_2) + cancel(p_2^2) - (q_1 - p_1)^2 - cancel((q_2 - p_2)^2) &= 0 \
(1/2)^2 - 2(1 / 2) (1/3) + (1/3)^2 + t_2 ^2 -(2/3 - 1/3)^2 &= 0

$
*/
/*
==== Construcció amb IFS

#proposition[Corba de Koch per IFS][
  _Nota._ 
  Donat el sistema de funcions iterades $(f_1, f_2, f_3, f_4)$ amb $
  
  f_1 (arr(x)) = 1 / 3 arr(x),
  wide f_2(arr(x)) = 1 / 3 mat(1/2, - sqrt(3)/2 ; sqrt(3)/2, 1/2) arr(x) + vec(1/3, 0), \
  f_3(arr(x)) = 1 / 3 mat(1/2, sqrt(3)/2 ; - sqrt(3)/2, 1/2) arr(x) + vec(1/2, sqrt(3)/6)
  wide f_4(arr(x)) = 1 / 3 arr(x) + vec(2/3, 0)
  $

  i la llista de proporcions $(1slash 4,1slash 4,1slash 4,1slash 4)$, la corba de Koch és la recursivitat

  $
  K = f_1 [K] union f_2 [K] union f_3 [K] union f_4 [K]
  $

  _Nota._ En aquesta proposició tractem els vectors com matrius d'una columna $vec(1, 2)$ i no com a parelles ordenades $(1, 2)$.

] <prop-koch-def>

#demo[de @prop-koch-def][
  #figure(caption: [Cinquena iteració de la corba de Koch.])[
  #figures.koch(2, only-one: true, size: 8, number: true)
]
  
  Les funcions de transformació convertiran el segment principal a cadascun dels 4 segments petits. Observem quines transformacions es fan:

  - _Segment 1._ Es redueix la mida en un terç. Cap translació.

  - _Segment 2._ Es redueix la mida en un terç, es desplaça
]
*/
==== Càlcul de la dimensió topològica

#proposition[La corba de Koch té una dimensió topològica 1.] <prop-koch-dim>

#demo[de @prop-koch-dim][
  La corba de Koch es comporta localment com una corba normal. Seguint el raonament de la demostració de la @prop-dim-corba, l'ordre mínim que es troba a tots els refinaments és 1, així que la dimensió topològica és 1.
]

==== Càlcul de la dimensió fractal

#proposition[La corba de Koch té dimensió fractal $log 4 slash log 3$] <prop-koch-dim-frac>

#demo[de @prop-koch-dim-frac][
  Busquem la dimensió auto-similar. La llista de proporcions és $(1 slash 3, 1 slash 3, 1 slash 3, 1 slash 3)$. Per tant:

  $
  sum^n_(i=1) r_i^s = 1 \
  4(1/3)^s = 1 <=> (1/3)^s = 1/ 4 <=> 3^s = 4 <=> s = log_3 4 = (log 4)/(log 3) approx "1,262" #qedhere
  $
  
]

== Fractals complexos

En aquesta secció abandonarem la geometria elemental i estudiarem dos fractals amb una definició simple, però un comportament ben estrany.

=== Conjunts de Julia

==== Definició

Els _conjunts de Julia_ són una família de fractals que són un cas concret de les IFS. Es defineixen en els nombres complexos $CC$ a partir d'una recurrència complexa.

Per exemple, el fractal de Julia més famós es basa en l'equació

$
z_(n+1) = z_n^2 + c
$

Donat un valor de $c$, per a cada punt del pla complex $z = x i + y$ on $i = sqrt(-1)$, calculem $z_(n+1)$ recursivament. Si $lim_(n->+infinity) z_n = +infinity$, aleshores el punt no pertany al conjunt de Julia. Si el límit convergeix a un valor finit, aleshores sí que hi pertany.

==== Conjunt de Mandelbrot

El _conjunt de Mandelbrot_ és el conjunt de Julia per a $c = z_0$. És el fractal més popular, ja que s'hi poden trobar un munt de formes, fins i tot a si mateix---és auto-similar.

=== Fractal de Newton

==== Mètode de Newton

El _fractal de Newton_ està basat en el mètode Newton per trobar les arrels d'una funció real.

$
x_(n+1) = x_n - (f(x_n))/(f'(x_n))
$

#figure(caption: [Funcionament del mètode de Newton amb $f(x)=x^2 - 4$ i una primera suposició $x_0 = 3.$ ])[
  #canvas({
    import draw: *
    import plot: *

    let r = x => 6*(x - 3) + 5
  
    plot(size: (5,5), x-tick-step: 2, y-tick-step: 2, axis-style: "school-book", name: "plot", {
      add(domain: (-2, 4), it => (it*it - 4), samples: 250)
      

      add-anchor("pt", (3,5))

      add(domain: (1, 4), r)
    })

    circle("plot.pt", radius: 0.05, fill: black)
    
  })
]

El procés és el següent:

- Fixar un $x_0$ qualsevol.
- Calcular $f(x_0)$. Si és 0, ja hem acabat.
- Calcular $f'(x_0)$.
- Traçar una recta tangent en $x_0$ amb l'equació punt-pendent i la derivada: $r colon y - f(x_0) = f'(x_0)(x - x_0)$
- Trobar el punt d'intersecció $x_1$ entre $r$ i l'eix d'abscisses.
- Repetir el procés amb $x_1$.

Per exemple, considerem la funció $f(x) = x^2 - 4$. La seva derivada és $f'(x)=2x$. Provem el punt $x_0 = 3$. Tenim que $f(3)=5$ i que $f'(3)=6$, així que l'equació de la recta tangent és $r_0: y -5 = 6(x-3)$. Resolent l'equació per a $y=0$, obtenim que la recta talla l'eix de les abscisses a $x = 13 slash 6 approx "2.167"$. Sabent que l'arrel més propera és $x=2$, l'error per a la primera iteració és $"0,167"$. Repetim el procés amb $x_1 = 13 slash 6$ i obtenim que l'equació de la recta és $r_1 = y - 25 slash 36 = 13 slash 3 dot (x - 13 slash 6)$. Resolent per a $y=0$ obtenim el punt $x_2 = 313 slash 156 approx "2,0064"$, amb un error encara més petit.

Podem obtenir una igualtat general per a $x_n$:

$
r colon y - f(x_n) = f'(x_n)(x_(n+1) - x_(n)), wide y=0 \

-f(x_n) = f'(x_n)(x_(n+1) - x_n) <=>-f(x_n) / (f'(x_n)) = x_(n+1) - x_n <=> x_(n+1) = x_n - f(x_n) / (f'(x_n))
$

Aquesta drecera ens permet obtenir aproximacions arbitràriament precises a una arrel de $f$ per a qualsevol $f$ derivable.


==== Comportament fractal del mètode de Newton

Sabem del cert que, amb infinites iteracions, qualsevol suposició inicial causarà que el valor acabi convergint a una arrel de la funció.

Si apliquem això als nombres complexos, obtenim un resultat molt interessant. L'equació de recurrència del mètode de Newton per a $CC$ és, anàlogament:

$
z_(n+1) = z_n - f(z_n)/(f'(z_n))
$

Aleshores, donada una funció $f: CC -> CC$, es divideix el pla complex en regions $G_i$ de manera que un punt del pla complex que convergeixi a l'arrel de la funció $phi_k$ es trobarà a la regió $G_k$.

#figure(caption: [_Domini públic._])[
  #image( width: 300pt, "../images/newton.png")
]

El conjunt complementari a una regió és un conjunt de Julia.

/*
== Atractors estranys
=== Teoria del caos

=== Atractor de Lorentz

== Fractals tridimensionals
Quaternions

*/
