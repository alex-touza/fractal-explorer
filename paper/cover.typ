#import "meta.typ": *
#import "src/figures.typ"
#import "@preview/cetz:0.2.2": canvas, draw, plot

#set par(leading: 0.5em, justify: false)

#set page(footer: [
  #set text(7pt)
  #set align(right)
  #datetime.today().display() --- 
  #if PRINT [Versió d'impressió
  ] else [Versió digital]
])

#align(horizon + center)[
  #set par(spacing: 0.5em)
  #place(top)[
    #box(stroke: (bottom: 2pt), inset: 16pt, width: 100%)[
      
      #text(size: 24pt, weight: 900, meta.title, hyphenate: false)
      
      #text(size: 16pt, weight: 500, meta.subtitle, hyphenate: false)
    ]
  ]
  

  
  
  #align(center + horizon)[
    
      
      #figures.koch-snowflake(sides: 5, size: 5, n: 5)
      
      #v(6em)
  ]
  

  #set par(spacing: 1em)

  #place(bottom)[
    #box(stroke: (top: 2pt), inset: 16pt, width: 100%)[
  
      #text(size: 15pt)[
        *Àlex Xavier Touza Luque*
  
        2n Batxillerat B
  
        Institut Ernest Lluch #sym.dash.em Curs 2024#{sym.dash.en}2025
      ]
  
      #v(0.5em)
  
      #text(size: 13pt)[
        25 d'octubre de 2024
  
        _Departament de Matemàtiques_ #sym.dash.em José Ramírez

        Treball de Recerca
      ]
      
    ]
  ]

  

  
]



#place(bottom + right, {
  if not FINISHED {
    text(size: 18pt, red)[
      ESBORRANY #datetime.today().display()
    ]
  } else if not CHECKED {
    text(size: 18pt, orange)[
      NO REVISAT #datetime.today().display()
    ]
  }

  v(16em)
  
 
})