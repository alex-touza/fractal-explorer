#import "../../meta.typ": *
#import "../environments.typ": *
#import "../shortcuts.typ": *

== Justificacions i demostracions matemàtiques
Per reduir la llargada del cos principal del treball, es presenten aquí demostracions d'algunes proposicions i teoremes, així com explicacions addicionals de les definicions matemàtiques presentades. #if not PRINT [Recordeu que les referències com #emph[@hausdorff-prop1] són clicables.]

#explanation[@def-topologia][
   Intuïtivament, una topologia sobre un conjunt és una forma d'expressar la proximitat (els veïnats) dels elements en un conjunt, sense cap noció de distància.

   Per exemple, considerem el conjunt $A = {1, 3, 10, 15, 17}$. Una topologia possible sobre aquest conjunt podria ser $tau_1 = {emptyset, A}$, ja que compleix les condicions: l'única intersecció possible, $emptyset sect A = emptyset$, i l'única unió possible, $emptyset union A = A$, estan dins del conjunt. Tanmateix, una topologia així no és gaire útil, perquè les relacions de proximitat no estan definides de forma acurada. Un exemple més útil podria ser $tau_2 = {emptyset, {10}, {15}, {10, 15}, A}$, en la qual expressem que els elements 10 i 15 són pròxims (o relacionats d'alguna altra forma).
]

#explanation[ambigüitats amb la dimensió intrínseca][
  Hem definit la dimensió intrínseca com el nombre de paràmetres requerits per obtenir els punts que formen l'objecte. Per tant, una funció com $f(x)=2$, que representa una recta, tindria dimensió 1, perquè el conjunt de punts es pot definir amb l'expressió ${(x,2) :  x in RR}$.
  
  Tanmateix, en contextos fora de la geometria o la topologia, com en el tractament de dades, la dimensió intrínseca és 0 si la funció és constant. Aleshores, la funció $f$ anterior tindria dimensió 0. Com aquest treball es centra en l'àrea de la topologia, aquesta definició no s'ha fet servir.
]


#explanation[@def-mesura-hausdorff][
  Primer, considerem tots els  recobriments-$delta$ (@def-recobriment-delta) possibles del conjunt $A$ que es vol mesurar: 
  $
  {{E_i : abs(E_i) <= delta } : A subset.eq union.big_i E_i }, delta in (0, +infinity)
  $
  
  Aleshores, per a cada recobriment, es calcula la suma dels diàmetres elevats a un nombre real positiu o nul $s$.
  
  $
  {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i}, delta in (0, +infinity), s in [0, +infinity)
  $
  
  Per últim, hem de tenir en compte que el conjunt $A$ podria ser un subconjunt propi de les unions de les col·leccions, és a dir, cada unió podria contenir elements que $A$ no conté. Per minimitzar aquest error, agafem l'ínfim de la col·lecció:
  

  $
  hausdorffdelta = inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
  
  $
  
  
  
  Interessa que els conjunts que formen el recobriment siguin el més petits possibles, és a dir, que $delta$ sigui el més petit possible. Si $delta$ es redueix, el nombre de col·leccions ---és a dir, recobriments possibles--- també redueix i aleshores l'ínfim augmenta (o no disminueix). Per tant, agafem el límit de $delta -> 0$:

  $
  hausdorff = lim_(delta -> 0) hausdorffdelta = lim_(delta -> 0)  inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
  $
  
  
  Finalment, aquesta expressió és la definició de la mesura de Hausdorff $s$-dimensional.
] <expl-mesura-hausdorff>

#demo[de @hausdorff-prop1][
  Fixem-nos en el sumatori dels diàmetres d'un sol recobriment. Si $s < t$, aleshores, sabent que $abs(E_i) <= delta$:

  $
  sum_i abs(E_i)^t = sum_i abs(E_i)^(t-s) abs(E_i)^s <= delta^(t-s) sum_i abs(E_i)^s
  $

  Si fem l'ínfim de la primera i l'última expressió per a tots els recobriments, tenim que:

  $
  cal(H)^t_delta (A) <= delta^(t-s)cal(H)^s_delta
  $


  Per obtenir la mesura de Hausdorff sense el paràmetre $delta$, fem el límit als dos costats:

  $
  cal(H)^t (A) <= lim_(delta -> 0) (delta^(t-s)cal(H)^s_delta) = 0 dot cal(H)^s
  $

  Com hem fixat que $cal(H)^s (A) > 0$, perquè es compleixi la desigualtat és necessari que #linebreak() $cal(H)^t = +infinity$.
] <dem-hausdorff-prop1>

#demo[de @hausdorff-prop2][
  Fem ús de la mateixa expressió que a la demostració anterior:
  
  $
  cal(H)^t (A) <= lim_(delta -> 0) (delta^(t-s)cal(H)^s_delta) = 0 dot cal(H)^s
  $
  
  Com hem fixat que $cal(H)^s (A) < +infinity$, tota l'expressió és nul·la: $cal(H)^t (A) = 0 qedhere$.
]

#demo[de @teorema-dim-autosimilar][
  Considerem la funció $ f(s)= sum^n_(i=1) r_i^s $ Com que tots els $r_i$ són positius, la funció és $f: [0, +infinity) -> [0,+infinity)$. Clarament, $f(0) = sum^n_(i=1) r_ i ^0 = sum^n_(i=1) 1= n$. Calculem el límit a l'infinit, tenint en compte que $0 < r_i < 1$:

  $
  lim_(s->+infinity) f(s) = lim_(s->+infinity) sum^n_(i=1) r_i^s = 0
  $

  Pel teorema del valor mitjà, com que $f$ és contínua, la funció passa per tots els valors a l'interval $(0, n)$ i per tant sabem que ha d'haver-hi almenys un valor $s$ tal que $f(s)=1$. Calculem la derivada de $f$:

  $
  f'(x) = sum^n_(i=1) r_i^s ln(r_i)
  $

  Com que $0 < r_i < 1$, el logaritme sempre serà negatiu i per tant la derivada també, així que $f$ és decreixent per tot $s in [0, +infinity)$. Així que si sempre decreix, només existirà una $s$ tal que $sum^n_(i=1) r_i^s = 1$.
]

#explanation[matrius en geometria analítica][
  En $RR^2$, les matrius són útils per realitzar transformacions en vectors. Les matrius unitàries, és a dir, aquelles matrius en què si es multipliquen per la seva matriu transposada el producte és la matriu identitat, representen transformacions de reflexió o rotació.
] <expl-matrius>

#demo[de @prop-cantor-def][
  Calculem $C_1$ com a exemple per mostrar el funcionament d'aquest sistema de funcions iterades. Fem servir $C_0 = [0, 1]$ com a conjunt inicial. Per calcular un $f_i [C_k]$, calcularem $f_i$ pels punts inicial i final de $C_k$.
  
  $
  C_1 = f_1 [C_0] union f_2 [C_0] \
  
  cases(
    display(f_1[C_0] = [f_1(0), f_1(1)] = [0, 1/ 3]),
    
    display(f_2[C_0] = [f_2(0), f_2(1)] = [2/3, 1])
  )
  => C_1 = [0, 1/ 3] union [2/3, 1]
  $
  
  Com es pot veure, la primera transformació ha partit correctament el segon terç del conjunt. Inductivament, sabem que aquesta operació es realitzarà sobre cada conjunt de les unions, ja que $f[A union B] = f[A] union f[B]$, i realitzar aquestes operacions infinites vegades obtindrem $C$.
]

#demo[de @prop-sierpinski-dim-top-menor-2][
  Aplicar les definicions estudiades de dimensió topològica no és una opció en fractals, així que tractem de trobar l'àrea.
  
  El conjunt $S_0$ està, lògicament, format per un sol triangle equilàter de costat 1. El conjunt $S_1$ està format per tres conjunts $S_0$ cadascun de costat $1/2$. Com que de cada triangle n'apareixen tres a la següent iteració, inductivament, deduïm que el conjunt $S_k$ conté $3^k$ triangles de costat $2^(-k)$ cadascun.
  
  Com que l'altura d'un triangle equilàter és $display(sqrt(2)/2 a)$, l'àrea d'un triangle a la iteració $k$ és de $ A_"triangle" = (sqrt(2) / 2 dot 2^(-k) dot 2^(-k))/2 = sqrt(2) dot 4^(-k-1) $ i l'àrea total per tant és $3^k dot sqrt(2) dot 4^(-k-1)$. Fem el límit:

  $
  lim_(k->+infinity) 3^k dot sqrt(2) dot 4^(-k-1) = 0
  $

  El terme $4^(-k-1)$ és el dominant. Alternativament, també es podria haver raonat que, com que a cada iteració s'elimina $1 slash 4$ de l'àrea del triangle, l'àrea total és $lim_(k->+infinity) (1 slash 4)^k = 0$.
  
  Que l'àrea sigui zero implica que la dimensió topològica ha de ser menor que 2.

]

#demo[de @prop-sierpinski-dim-top-1][
  Apliquem la definició de la dimensió de recobriment de Lebesgue.

  Podem cobrir la fractal amb un sol conjunt, però ho descartarem. Per a qualsevol recobriment, podem refinar-lo de manera que només els vèrtexs dels triangles estiguin a dos conjunts a la vegada. Per tant, la dimensió topològica és 1.
]

