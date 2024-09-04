#import "src/environments.typ": *
#import "src/utilities.typ": *
#import "src/style/headings.typ": *
#import "src/style/page.typ": *
#import "meta.typ": *
#show: thmrules

#show: style_headers


#set document(..meta)


#set text(font: "New Computer Modern", size: 11pt, lang: "ca")

#set par(leading: 1.15em, justify: true, linebreaks: "optimized")
#show par: set block(below: 2em)

#show figure.caption: set text(size: 10pt)

#{
  set par(leading: 0.5em)
  text(size: 20pt, weight: 900, meta.title)

  align(bottom + right, {
    if not FINISHED {
      text(size: 15pt, red)[ESBORRANY #datetime.today().display()]
    } else if not CHECKED {
      text(size: 15pt, orange)[NO REVISAT #datetime.today().display()]
    }
      
    
  })

}

#pagebreak()

#set page(footer: context {
    let num = counter(page).get().first()

    
    set align(if calc.odd(num) { right } else { left })
    set text(10pt)


    num
  
  })

#preface_heading("Agraïments")

Als contribuïdors del sistema de composició tipogràfica Typst, utilitzat en aquest treball.

Als contribuïdors del fòrum Stack Exchange Mathematics, que han proveït materials d'ajuda i explicacions que han resultat imprescindibles.




#pagebreak()
#preface_heading("Abstract")


#preface_heading("Resumen")

#pagebreak()

#let outline = outline(title: "Taula de continguts", indent: 1em)

#outline

#pagebreak()




#set par(first-line-indent: 2em)


#show heading.where(level: 1): set heading(numbering: n => [])

#show heading.where(level: 1): it => {
  set text(size: 24pt)
  
  block(below: 6em)

  let num = counter(heading).at(it.location()).first()

  [Capítol #num]
  
  it

  block(below: 2em)

}

#show heading.where(level: 4): it => {
  block(text(style: "italic", weight: "regular", it.body), below: 2em)
}


#include "src/chapters/1_introduccio_a_la_geometria_fractal.typ"
#pagebreak()
#include "src/chapters/2_estudi_matemàtic_dels_objectes_fractals.typ"
#pagebreak()
#include "src/chapters/3_estudi_computacional_dels_objectes_fractals.typ"



= Conclusió

= Annexos

#include "src/annexes/glossary.typ"
#include "src/annexes/proofs.typ"

== Annex 3: Descripció de la interfície de l'explorador de fractals


== Annex 4: Fragments de codi

= Bibliografia

#sym.space.nobreak

#bibliography("bib.yaml", style: "american-psychological-association", title: none, full: true)