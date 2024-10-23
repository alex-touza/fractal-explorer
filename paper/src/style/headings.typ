#let style_headings = document => {
  set heading(numbering: "1.1.")

  
  
  show heading.where(level: 1): set heading(numbering: "1.")

  show heading.where(level: 1): it => {
    set text(hyphenate: false)
    set text(size: 24pt)
    set par(first-line-indent: 0em, hanging-indent: 0em)
    
    block(below: 3em)
  
    let num = counter(heading).at(it.location()).first()

    context {
      if here().page-numbering() == "1" {
        block(text[
      Capítol #num

    ])
      }
    }
    

    block(text[
      #it.body
    ])

   
  
    block(below: 1em)
  
  }
  
  show heading.where(level: 4): it => {
    block(text(style: "italic", weight: "regular", it.body), below: 2em, above: 2em)
  }
  
  document
}

#let style_preface_heading = document => {
  show heading.where(level: 1): set heading(numbering: none)
  show heading.where(level: 1): it => {
    set text(hyphenate: false)
    set text(size: 24pt)
    set par(first-line-indent: 0em, hanging-indent: 0em)
    
    block(below: 3em)
  
    block(text[
      #it.body
    ])

   
  
    block(below: 0.5em)
  
  }
  
  document
}

#let style_annex_headings = document => {

  show heading: set heading(numbering: none)

  show heading.where(level: 2): set heading(numbering: (a, b) => [Annex #(b - 2):])
  document
}

#let preface_heading(t) = {
  //show text: smallcaps
  show heading: set text(size: 17pt)
  heading(outlined: false, numbering: none, smallcaps(t))
}