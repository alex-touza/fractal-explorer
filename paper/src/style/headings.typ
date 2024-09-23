#let style_headers = document => {
  set heading(numbering: "1.1.")
  
  show heading.where(level: 1): set heading(numbering: n => [])

  show heading.where(level: 1): it => {
    set text(size: 24pt)
    
    block(below: 6em)
  
    let num = counter(heading).at(it.location()).first()
  
    [Capítol #num]
    
    it
  
    block(below: 2em)
  
  }
  
  show heading.where(level: 4): it => {
    block(text(style: "italic", weight: "regular", it.body), below: 2em, above: 3em)
  }
  
  document
}

#let preface_heading(t) = {
  //show text: smallcaps
  show heading: set text(size: 17pt)
  heading(outlined: false, numbering: none, t)
}