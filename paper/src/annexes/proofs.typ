#import "../../meta.typ": *
#import "../environments.typ": *
#import "../shortcuts.typ": *

== Justificacions i demostracions matemàtiques
Per reduir la llargada del cos principal del treball, es presenten aquí demostracions d'algunes proposicions i teoremes, així com explicacions addicionals de les definicions matemàtiques presentades. #if not PRINT [Recordeu que les referències com #emph[@hausdorff-prop1] són clicables.]


#explanation[de @def_mesura_hausdorff][
  La idea d'aquesta mesura és considerar tots els  recobriments-$delta$ (@recobriment-delta) possibles del conjunt $A$ que es vol mesurar: 
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
  
  
  
  Si $delta$ es redueix, el nombre de col·leccions ---és a dir, recobriments possibles--- també redueix i aleshores l'ínfim augmenta (o no disminueix). Per tant, agafem el límit de $delta -> 0$:

  $
  hausdorff = lim_(delta -> 0) hausdorffdelta = lim_(delta -> 0)  inf {sum_i abs(E_i)^s : abs(E_i) <= delta, A subset.eq union.big_i E_i }, s in [0, +infinity), delta in RR
  $
  
  
  Finalment, aquesta expressió és la definició de la mesura de Hausdorff $s$-dimensional.
]

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