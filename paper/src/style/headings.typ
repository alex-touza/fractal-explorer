#let style_headers = document => {
  set heading(numbering: "1.1.")

  document
}

#let preface_heading(t) = {
  //show text: smallcaps
  show heading: set text(size: 17pt)
  heading(outlined: false, numbering: none, t)
}