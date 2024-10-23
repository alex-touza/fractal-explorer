#import "src/environments.typ": *
#import "src/utilities.typ": *
#import "src/style/headings.typ": *
#import "src/style/page.typ": *
#import "meta.typ": *
#import "@preview/wordometer:0.1.2": word-count, total-words
#import "@preview/hydra:0.5.1"
#import "@preview/droplet:0.2.0": dropcap

#show: thmrules



#set document(title: meta.title)


#set text(font: "New Computer Modern", size: 11pt, lang: "ca")
#set align(left)
#set par(leading: 1.25em, justify: true, spacing: 2em, linebreaks: "optimized")

#show figure.caption: set text(size: 10pt)

#include "cover.typ"

/*
#pagebreak()

#place(bottom + right, text(9pt)[
  Compilat amb Typst 0.12.0 - #datetime.today().display()
  
  #if PRINT [
    Versió d'impressió
  ] else [
    Versió digital
  ]
])
*/

#pagebreak()
#set page(numbering: "I")
#counter(page).update(1)

#set page(footer: context {
    let num = counter(page).get().first()


    set align(center)
    set text(10pt)

    if here().page-numbering() != none {
      numbering(here().page-numbering(), num)
    }
    
  
  })

#preface_heading("Agraïments")

Als contribuïdors del sistema de composició tipogràfica Typst, utilitzat en aquest treball.

Als contribuïdors del fòrum Stack Exchange Mathematics i als diversos autors de les fonts utilitzades de Internet, que han proveït materials d'ajuda i explicacions que han resultat imprescindibles per a la comprensió de la literatura matemàtica.

Als meus amics i família, pel seu suport.

#v(1em)

/*
== Paquets de Typst

Aquesta memòria ha estat escrita amb Typst. Dono les gràcies als autors dels paquets que he fet servir i que han contribuït a la bona presentació del treball.

- `ctheorems` (MIT License) - _Satvik Saha, Rory Molinari, Michael Hutchinson & DVDTSB_
- `hydra` (MIT License) - _tinger_
- `cetz` (GNU Lesser General Public License v3.0) - _Johannes Wolf & fenjalien_
- `dashy-todo` - _Otto-AA_
- `suiji`

*/


#pagebreak()

#heading(outlined: false)[Abstract]
//#preface_heading("Abstract")

#heading(outlined: false)[Resumen]
//#preface_heading("Resumen")

#v(1em)

Paraules clau: _fractals_, _topologia_, _dimensió_, _geometria_, _algorísmia_

#pagebreak()



#show outline.entry.where(level: 1): it => {
  v(0.5em)
  set text(weight: "bold")

  it
}


#outline(title: "Taula de continguts", indent: 1em )

#metadata(()) <front-matter>
#pagebreak()




#set par(first-line-indent: 2em)




#set page(numbering: "1")
#counter(page).update(1)



#show: style_preface_heading
= Prefaci

Aquest treball ha consistit en un aprofundiment en la geometria fractal, especialment la base matemàtica i la seva generació. L'elecció d'aquest tema ha estat motivada per la voluntat inicial d'unir les disciplines d'informàtica i matemàtiques. Per un costat, la visualització de fractals és un problema computacional molt conegut entre programadors i, per l'altre, les fractals són formes geomètriques populars però que solen ser vistes com fenòmens estranys, per la qual cosa semblava intrigant poder trobar-ne l'explicació matemàtica.

Seguint el desig de centrar-se en la base matemàtica de les fractals, s'ha donat més pes a la part teòrica del treball. I com hom podia esperar, les matemàtiques de la geometria fractal no són simples; es basen fonamentalment en topologia i teoria de mesura, branques de les matemàtiques pròpies d'un grau universitari. Tanmateix, el coneixement previ de l'autor sobre geometria i teoria de conjunts han permès, si bé no de forma exhaustiva, poder explorar aquests temes. A més, s'ha pogut tenir accés a una àmplia literatura matemàtica sobre el tema, gairebé tota en anglès, que, amb l'ajut de materials a Internet, s'han tractat d'entendre i s'han exposat aquí tal com s'ha cregut més apropiat. Es destaquen els llibres _Measure, Topology, and Fractal Geometry_ de Gerald Edgar i _The Fractal Geometry of Nature_ de Benoît Mandelbrot, que s'han pogut aconseguir en paper i han estat la base de bona part del treball.

Aquesta recerca sobre les fractals ha portat a conèixer amb certa profunditat conceptes de topologia com la dimensió, el recobriment i la mesura, a més de tot allò relacionat directament amb la geometria fractal. Com a exercici addicional, s'ha tractat de formalitzar la majoria de definicions i, per demostrar la seva comprensió, als annexos els lectors trobaran explicacions detallades dels conceptes més complexos.



L'autor voldria ressaltar l'ús del sistema de composició tipogràfica Typst, que s'ha servit per aconseguir una satisfactòria presentació del treball així com per mostrar correctament les expressions matemàtiques, les gràfiques i els diagrames. És similar a LaTeX, àmpliament usat en articles científics.

Per una banda, el marc teòric del treball, que és aquesta mateixa memòria, es divideix en tres capítols: una perspectiva històrica i qualitativa de les fractals, un aprofundiment matemàtic i, finalment, un anàlisi algorísmic.

En primer lloc, el capítol 1 exposa breument la història dels objectes fractals, on es poden trobar a la natura i les característiques que s'hi associen. En segon lloc, el capítol 2 consisteix en el nucli matemàtic del projecte, explorant el concepte de dimensió i dos dels tipus de fractals més importants. En tercer lloc, el capítol 3 estudia els mètodes per generar els objectes fractals i ho relaciona amb la part pràctica del treball. Finalment, els annexos inclouen un glossari amb termes de matemàtiques i informàtica rellevants i necessaris per a la comprensió del contingut de la memòria, una sèrie d'explicacions, justificacions i demostracions matemàtiques i uns comentaris sobre la part pràctica del treball.
/*
En un intent de presentar el treball com es sol fer en articles matemàtics, la memòria està organitzada amb proposicions, definicions i demostracions numerades i enllaçades. Algunes definicions es localitzen al principi del capítol corresponent si el seu contingut no s'explica directament al cos.
*/

Per l'altra banda, la part pràctica d'aquest projecte ha estat la creació d'una aplicació web que genera objectes fractals i proveeix eines per a explorar-los còmodament i interactuar amb ells. Aquesta tasca és fruit dels coneixements del segon i, sobretot, del tercer capítol.

Totes les figures mostrades, si no s'expressa el contrari, són originals. El codi font d'aquesta memòria, de l'aplicació web i de la presentació està disponible a #printable-hyperlink("GitHub", "https://github.com/alex-touza/fractal-explorer").

#show: style_headings

#pagebreak()
#include "src/chapters/1_introduccio_a_la_geometria_fractal.typ"
#pagebreak()
#include "src/chapters/2_estudi_matemàtic_dels_objectes_fractals.typ"
#pagebreak()
#include "src/chapters/3_estudi_computacional_dels_objectes_fractals.typ"


#pagebreak()

#show: style_preface_heading
= Conclusió

= Bibliografia
#sym.space.nobreak

#bibliography("bib.yaml", style: "american-psychological-association", title: none, full: true)

/*
Per què la bibliografia ha ser part del cos de la memòria? No té sentit.
*/

#set page(numbering: "I")
#context counter(page).update(counter(page).at(<front-matter>).first() + 1)

#pagebreak()

#show: style_annex_headings
= Annexos

#include "src/annexes/glossary.typ"
#include "src/annexes/proofs.typ"

== Descripció de la interfície de l'explorador de fractals


== Fragments de codi


#pagebreak()

#show: style_preface_heading



