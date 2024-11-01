#let glossary(items) = {
  return () => {
    v(1em)
    for (term, definition) in items.sorted() [/ #term: #definition]
  }
}



== Glossari

=== Termes matemàtics

#let math_terms = glossary((
  (
    "derivabilitat",
    [
      Propietat d'un punt d'una funció de ser derivable, és a dir, que s'hi pugui traçar una recta tangent.
    ]
  ),
  (
    "conjunt obert",
    [
      Conjunt que no inclou el seu contorn. Per exemple, $(0, 1)$ és un conjunt obert però $[0, 1]$ no ho és.
    ]
  ),
  (
    "conjunt tancat",
    [
      Conjunt que inclou el seu contorn. Per exemple, $[0, 1]$ és un conjunt obert però $(0, 1)$ no ho és.
    ]
  ),
  (
    "conjunt fitat",
    [
      Conjunt tal que existeix alguna distància $d$ tal que qualsevol parella de punts del conjunt tinguin una distància menor que $d$. Per exemple, $(3, 4)$ i $[-1, 1]$ són conjunts fitats però $(-infinity, 10]$ no ho és.
    ]
  ),
  (
    "producte cartesià",
    [
      Operació binària denotada amb $times$ entre conjunts que retorna totes les parelles possibles formades per un element de cada operand.
    ]
  )
))

#math_terms()
/*
=== Termes d'algorísmia
 
#let algorithms_terms = glossary((
  (
    "complexitat temporal",
    [
      Com creix el temps que triga a executar-se un algoritme en funció de les variables d'entrada. Per exemple, $O(n^2)$ indica que si es dobla el nombre d'ítems d'entrada, es quadruplica el temps d'execució.
    ]
  ),
  (
    "recursivitat",
    [
      Propietat d'alguna a cosa a estar definida a partir d'una versió o una còpia de si mateixa. Moltes fractals són conjunts recursivament definits. En algorísmia, per exemple, una algorisme és recursiu quan un dels passos és l'algorisme mateix.
    ]
  )
))

#algorithms_terms()
*/