#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/cetz:0.2.2": canvas, draw

= Estudi matemàtic dels objectes fractals

En aquesta part del treball, s'exposaran les matemàtiques que estudien els objectes fractals. La primera secció introdueix el concepte de dimensions fractals, començant amb la noció intuïtiva de dimensió, i la seva utilitat en l'estudi de les fractals. La segona i tercera secció estudien els exemples més coneguts dels dos grans tipus de fractals: els sistemes de funcions iterades i els fractals de funcions sobre el pla.

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
  Una funció $f: A -> B$ és una _transformació homeomorfa_ o un _homeomorfisme_ si es compleix que tant $f$ com $f^(-1)$ són contínues en tot el seu domini ($A$ i $B$ corresponentment) i que $f$ és bijectiva, és a dir, hi ha una relació un a un entre $A$ i $B$ (simbòlicament, $forall b in B med exists! a in A : f(a) = b$, on $exists!$ vol dir "existeix només un").

  Per exemple, la funció $f(x) = x^3$ és un homeomorfisme perquè és clarament bijectiva i contínua en tot $RR$, i la seva funció inversa $f^(-1)=root(3, x)$ és contínua. En canvi, la funció $g(x)=x^2$ ni és bijectiva ni la seva funció inversa $g^(-1)=sqrt(x)$ és contínua, així que no és un homeomorfisme.

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
] <def-refinament>



#def[Funció gamma][
  La _funció gamma_ $Gamma(z)$ està definida als nombres complexos amb part real positiva i és una extensió del concepte de factorial, definit només a nombres enters positius, a aquest conjunt superior. La funció es defineix així:
  
  $
  Gamma(z) = integral^infinity_0 t^(z-1) e^(-t) dif t
  $
  
  Es compleix que, per a tot $n$ enter positiu, $Gamma(n) = (n-1)!$, i, similarment al factorial, per a tot $z$ complex, $Gamma(z+1) = z Gamma(z)$.
] <funcio-gamma>

// p.92
== Dimensió topològica


Associem a qualsevol conjunt un valor anomenat _dimensió_. Per a la geometria elemental,

A la geometria fractal, és fonamental el concepte de _dimensió_. AquestaEn aquesta secció definirem amb rigor aquest terme, començant pels casos més simples amb la noció de dimensió comuna i acabant amb la dimensió fractal més utilitzada.


Utilitzem el terme _dimensió comuna_ per diferenciar el concepte usual de dimensió utilitzat en geometria bàsica i les diferents dimensions fractals. Sovint, informalment, es defineix la dimensió com el nombre d'eixos de coordenades. Tanmateix, a les matemàtiques aquest terme té moltes definicions diferents, de vegades equivalents i altres no.



=== Dimensió intrínseca

Determinar la dimensió d'un espai euclidià#footnote[El terme _espai euclidià_ es pot referir a un entorn $EE^3$ o $EE^n$ depenent del context.] $EE^n$ és trivial: per definició, la seva dimensió és $n$, és a dir, el nombre de coordenades que hem de fer servir per localitzar qualsevol punt a l'espai. Però és més interessant trobar la dimensió dels propis objectes que inserim en un espai.

Anomenem dimensió intrínseca o paramètrica d'un objecte el nombre de paràmetres requerits per obtenir els punts que el formen. Per mostrar de forma senzilla aquest mètode, demostrem les dues proposicions següents:

#proposition[
  Una circumferència té dimensió 1.
] <prop-circum-dim>

#proposition[
  Un pla té dimensió 2.
] <prop-pla-dim>

#demo[de @prop-circum-dim][
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
  
  Per tant, com només fa falta un sol paràmetre per obtenir els punts que formen la circumferència, aquest té dimensió 1.#footnote[Recordem que l'interior d'una circumferència no forma part d'ella. Quan ens referim a l'àrea d'una circumferència, llavors, realment estem parlant del seu interior.]
]

#demo[de @prop-pla-dim][
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

  Per tant, com que podem expressar els punts del pla $pi$ amb dos paràmetres, l'objecte té dimensió 2. De nou, és interessant observar que, tot i que el pla es trobi en un entorn tridimensional, a $RR^3$, l'objecte en si té dimensió 2.
]

Observeu com si haguéssim aplicat la definició informal amb "eixos de coordenades", erròniament hauríem associat la dimensió 2 a la circumferència i la dimensió 3 al pla. La dimensió és una propietat intrínseca de l'objecte, així que no pot dependre de l'entorn en què estigui inserit.


Ara, considerem una corba a $RR^2$. Una corba es pot deformar en una recta a $RR^1$, però, intuïtivament, no podem transformar una recta en un punt només deformant-lo perquè una recta té una llargada mentre que un punt no en té (@fig-homeomorfismes). Observeu com els dos primers objectes, la corba i la recta, són ambdós dimensió 2, però el punt té dimensió 1. Això fa pensar que certes transformacions són possibles només si els objectes tenen la mateixa dimensió. Aquestes deformacions s'anomenen _homeomorfismes_ (@def-homeomorfisme) i, per tant, la dimensió és una propietat topològica (@def-prop-topologica) perquè les transformacions homeomorfes  no alteren la dimensió de l'objecte. Per aquest motiu, el concepte de dimensió que s'ha exposat sol ser referit com a _dimensió topològica_.

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




#def[Dimensió de recobriment de Lebesgue o dimensió topològica][
  Sigui $n$ un nombre enter tal que $n >= 1$. Diem que un conjunt $S$ té _dimensió de recobriment de Lebesgue_ $<= n$ si i només si cada recobriment obert de $S$ (@def-recobriment) té un refinament (@def-refinament) amb ordre $<= n$ (@def-ordre).

  Aleshores, clarament, el valor de la dimensió de recobriment de Lebesgue és $n$ si és $<= n$ però no $<= n-1$. @Edgar1990
] <def-dim-lebesgue>

== Dimensió fractal
=== Dimensió de Hausdorff

Fins ara hem estudiat el concepte dimensió en formes bàsiques: corbes, circumferències, plans, rectes... I, de fet, en la majoria de situacions de geometria euclidiana, l'estudi de la dimensió no va molt més enllà. Tanmateix, resulta que la dimensió topològica resulta ser insuficient per estudiar els objectes fractals.

==== Mesures de Lebesgue

Considerem el concepte bàsic de distància. Un espai euclidià és un espai mètric (@def-espai-mètric) $EE^n = (RR^n, d)$ on $d$ és la distància euclidiana (@def-mesura-distancia). Aleshores, a $EE^2$, $d(x, y) = sqrt((x_0 - y_0)^2 + (x_1 - y_1)^2 )$

Quan parlem de mesura de Lebesgue, és només una forma més elegant de referir-se a les mesures convencionals de llargada, àrea, volum, etc, per a $RR^1$, $RR^2$, $RR^3$, ..., $RR^n$. És a dir, és una generalització del concepte de _llargada_ per a qualsevol dimensió $n$. Denotem $cal(L)^n$ com la mesura de Lebesgue a $RR^n$ (altres notacions en són $lambda^n$ o $"vol"^n$).

La mesura de Lebesgue, tanmateix, no és convenient quan tenim un subconjunt $m$-dimensional de $R^n$ amb $m < n$ @morgan-measures. Per exemple, considerem una corba $A$ en un pla, que és una varietat $RR^1$ a $RR^2$. La mesura de Lebesgue no ens permetria calcular la llargada d'aquesta corba: $cal(L)^2(A) = 0$ perquè $cal(L)^2$ és l'àrea i una corba no en té, i $cal(L^1)(A)$ no existeix perquè $cal(L)^n$ només funciona per a subconjunts de $RR^n$. En definitiva, aquesta mesura no serveix en aquestes situacions.

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

==== Mesura de Hausdorff


La mesura de Hausdorff ve motivada per calcular la _llargada_ (és clar, de forma genèrica per a qualsevol dimensió) de qualsevol subconjunt d'un espai mètric, evitant els problemes que causa la mesura de Lebesgue.

#def[Mesura de Hausdorff][
  Definim *la mesura de Hausdorff* $s$-dimensional com la suma més petita possible de diàmetres elevats a $s$ dels conjunts que formen una cobertura-$delta$, amb $delta$ tendint a zero. Simbòlicament:

  $ hausdorff = lim_(delta -> 0)  inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
$
] <def-mesura-hausdorff>



La justificació d'aquesta definició està explicada amb summe detall a l'annex corresponent.


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



/*

Considerem de nou l'@eq-hausdorff-delta. Observem que si $delta < 1$, #hausdorffdelta decreix o no augmenta amb $s$. És a dir, que per $s < t$ i $delta < 1$, necessàriament es compleix que:

$
cal(H)^s_delta (A) >= cal(H)^t_delta (A) 
$

I com @eq-hausdorff és el límit amb $delta -> 0$, similarment:
*/

La mesura de Hausdorff compleix les següents proposicions, la demostració dels quals es troba a l'annex:

#proposition[
  Si $cal(H)^s (A) > 0$ i $s < t$, aleshores $cal(H)^t (A) = +infinity$.
  
] <hausdorff-prop1>

#proposition[
  Si $cal(H)^t (A) < +infinity$ i $s < t$, aleshores $cal(H)^s (A) = 0$.
  
] <hausdorff-prop2>



Aquestes proposicions impliquen que la mesura de Hausdorff $s$-dimensional és o bé $+infinity$ per a valors petits de $s$ o bé 0 per a s valors grans de $s$, excepte un valor molt concret. Aquest valor de $s$ és la dimensió de Hausdorff. Per tant, podem definir-la així:

$
dim_"H " A = inf{s : hausdorff = 0} = sup{s : hausdorff = +infinity}
$

=== Dimensió autosimilar //p. 118

=== Condició del conjunt obert

== Fractals de sistemes de funcions iterades
Aquests tipus de fractals també s'anomenen Sistemes de Funcions Iterades, o _IFS_ per abreviar.

=== Triangle i catifa de Sierpinski

=== Conjunt de Cantor

=== Estel de Koch

== Fractals de funcions sobre el pla

=== Conjunts de Julia

=== Conjunt de Mandelbrot

=== Fractal de Newton
/*
== Atractors estranys
=== Teoria del caos

=== Atractor de Lorentz

== Fractals tridimensionals
Quaternions

*/
