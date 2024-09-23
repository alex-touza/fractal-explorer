// unnumbered title page if needed
// ...

Title

#pagebreak()
// front-matter
#set page(numbering: "I")
#counter(page).update(1)
// ...

Acknowledgments

#pagebreak()
#outline()

// page counter anchor
#metadata(()) <front-matter>
#pagebreak()




// main document body
#set page(numbering: "1")
#counter(page).update(1)

/* HERE. Still using Roman numbers instead of Arabic. */
= Something

#lorem(4000)

// back-matter
#set page(numbering: "I")
// must take page breaks into account, may need to be offset by +1 or -1
#context counter(page).update(counter(page).at(<front-matter>).first() + 1)

= Glossary
#lorem(50)