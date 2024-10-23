#import "meta.typ": *

#set par(leading: 0.5em, justify: false)

#align(horizon + center)[
  #set par(spacing: 0.5em)
  #place(top)[
    #box(stroke: (bottom: 2pt), inset: 16pt, width: 100%)[
      
      #text(size: 24pt, weight: 900, meta.title, hyphenate: false)
      
      #text(size: 16pt, weight: 500, meta.subtitle, hyphenate: false)
    ]
  ]
  

  
  

  #box(outset: (y: 6em), height: 400pt)[
    
  ]

  #set par(spacing: 1em)

  #place(bottom)[
    #box(stroke: (top: 2pt), inset: 16pt, width: 100%)[
  
      #text(size: 15pt)[
        *Àlex Xavier Touza Luque*
  
        2n Batxillerat B
  
        Institut Ernest Lluch #sym.dash Curs 2024-2025
      ]
  
      #v(0.5em)
  
      #text(size: 13pt)[
        25 d'octubre de 2024
  
        Departament de Matemàtiques #sym.dash José Ramírez
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

  v(15em)
  
 
})