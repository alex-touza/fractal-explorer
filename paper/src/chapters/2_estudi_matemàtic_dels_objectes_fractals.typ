#import "../environments.typ": *
#import "../utilities.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw

= Estudi matemàtic dels objectes fractals

En un intent de simplificar les definicions, s'ha optat per no fer ús del terme _espai mètric_ i utilitzar més simplement el terme _conjunt_. Per aquest motiu, cal tenir en compte que sempre que es faci servir aquest últim terme, la definició és vàlida per a qualsevol espai mètric.

#def[Diàmetre][
  Donat un conjunt $E = {x_1, x_2, ..., x_n}$, definim el seu _diàmetre_, denotat amb $abs(E)$, com la distància més gran possible entre qualsevol parella de punts. Simbòlicament, $abs(E) = sup { d(x_i, x_j) : x_i,x_j in E}$.
]

#def[Recobriment-$delta$][
  Donat un conjunt $A$, un _recobriment-$delta$_ és una col·lecció comptable ${ E_i }$ de conjunts amb diàmetres $abs(E_i) <= delta$ tals que el conjunt $A$ conté la unió de tots els conjunts de la col·lecció. Simbòlicament#footnote[La definició real d'un recobriment fa ús de _conjunts indexats_ però s'ha optat per usar una definició simplificada.]: $ C_delta (A) = {E_i : abs(E_i) <= delta}, A subset.eq union.big_i E_i $
] <recobriment-delta>

#def[Funció gamma][
  La _funció gamma_ $Gamma(z)$ està definida als nombres complexos amb part real positiva i és una extensió del concepte de factorial, definit només a nombres enters positius, a aquest conjunt superior. La funció es defineix així:
  
  $
  Gamma(z) = integral^infinity_0 t^(z-1) e^(-t) dif t
  $
  
  Es compleix que, per a tot $n$ enter positiu, $Gamma(n) = (n-1)!$, i, similarment al factorial, per a tot $z$ complex, $Gamma(z+1) = z Gamma(z)$.
] <funcio-gamma>

#def[Ordre][
  Donada una col·lecció de conjunts $cal(A)$
]

#def[Dimensió de recobriment de Lebesgue o dimensió topològica][
  Sigui $n >= 1$ un enter

  En espais euclidians, la dimensió topològica és la dimensió euclidiana convencional. @Edgar1990
]
// p.92
== Dimensions fractals

El concepte de dimensió, en matemàtiques avançades, té molts significats; no es limita només al nombre d'eixos per representar una forma geomètrica a l'espai euclidià. Específicament, aquesta mesura s'anomena _dimensió topològica_.

Si bé la dimensió topològica es pot entendre intuïtivament, la seva definició formal no és tan senzilla.

La dimensió fractal és la forma més utilitzada de



=== Dimensió de Hausdorff

==== Mesura de Lebesgue

Abans d'exposar les diferents dimensions de les fractals, 

Quan parlem de mesura de Lebesgue, és només una forma més elegant de referir-se a les mesures convencionals de llargada, àrea, volum, etc, per a $RR^1$, $RR^2$, $RR^3$, ..., $RR^n$. És a dir, és una generalització del concepte de _llargada_ per a qualsevol dimensió $n$. Denotem $cal(L)^n$ com la mesura de Lebesgue a $RR^n$ (altres notacions en són $lambda^n$ o $"vol"^n$).

La mesura de Lebesgue, tanmateix, no és convenient quan tenim un subconjunt $m$-dimensional de $R^n$ amb $m < n$ @morgan-measures. Per exemple, considerem una corba $A$ en un pla, que és una varietat $RR^1$ a $RR^2$. La mesura de Lebesgue no ens permetria calcular la llargada d'aquesta corba: $cal(L)^2(A) = 0$ perquè $cal(L)^2$ és l'àrea i una corba no en té, i $cal(L^1)(A)$ no existeix perquè $cal(L)^n$ només funciona per a subconjunts de $RR^n$. En definitiva, aquesta mesura no serveix en aquestes situacions.

#todo[Il·lustració de corba en un pla.]

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
] <def_mesura_hausdorff>



La justificació d'aquesta definició està explicada amb summe detall a l'annex corresponent.


#theorem[Relació entre la mesura de Lesbegue i la mesura de Hausdorff][ Donat un conjunt $A$ $n$-dimensional tal que $A subset RR^n$ i la mesura de Hausdorff $n$-dimensional del conjunt $A$ on $n$ és un nombre enter positiu, la mesura de Hausdorff i la mesura de Lebesgue segueixen la relació
  
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

== Fractals de recursivitat geomètrica
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

#pagebreak()
#pagebreak()
#pagebreak()
