#import "src/environments.typ": *
#import "src/utilities.typ": *
#import "src/style/headings.typ": *
#import "src/style/page.typ": *
#import "meta.typ": *
#import "@preview/wordometer:0.1.2": word-count, total-words


#show: thmrules

#show: style_headers

#set document(..meta)


#set text(font: "New Computer Modern", size: 11pt, lang: "ca")

#set par(leading: 1.25em, justify: true, linebreaks: "optimized")
#show par: set block(below: 2em)

#show figure.caption: set text(size: 10pt)

#{
  set par(leading: 0.5em)
  text(size: 20pt, weight: 900, meta.title)

  align(bottom + right, {
    if not FINISHED {
      text(size: 15pt, red)[
        ESBORRANY #datetime.today().display()
      ]
    } else if not CHECKED {
      text(size: 15pt, orange)[
        NO REVISAT #datetime.today().display()
      ]
    }
    
   
  })

}


#pagebreak(to: "odd")
#set page(numbering: "I")
#counter(page).update(1)

#set page(footer: context {
    let num = counter(page).get().first()


    
    set align(if calc.odd(num) { right } else { left })
    set text(10pt)

    num
  
  })

#preface_heading("Agraïments")

Als contribuïdors del sistema de composició tipogràfica Typst, utilitzat en aquest treball.

Als contribuïdors del fòrum Stack Exchange Mathematics, que han proveït materials d'ajuda i explicacions que han resultat imprescindibles.




#pagebreak(to: "odd")
#preface_heading("Abstract")


#preface_heading("Resumen")

#pagebreak(to: "odd")

#let _outline = outline(title: "Taula de continguts", indent: 1em)


#_outline

#pagebreak(to: "odd")




#set par(first-line-indent: 2em)




#set page(numbering: "1")
#counter(page).update(1)


// Introducció

#include "src/chapters/1_introduccio_a_la_geometria_fractal.typ"
#pagebreak()
#include "src/chapters/2_estudi_matemàtic_dels_objectes_fractals.typ"
#pagebreak()
#include "src/chapters/3_estudi_computacional_dels_objectes_fractals.typ"



= Conclusió

#set page(numbering: "I")
#counter(page).update(1)

= Annexos

#include "src/annexes/glossary.typ"
#include "src/annexes/proofs.typ"

== Annex 3: Descripció de la interfície de l'explorador de fractals


== Annex 4: Fragments de codi

= Bibliografia

#sym.space.nobreak

#bibliography("bib.yaml", style: "american-psychological-association", title: none, full: true)
