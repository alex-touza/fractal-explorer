#set text(font: "New Computer Modern", lang: "ca", 14pt)

#text(size: 20pt, weight: "bold")[Guió presentació treball de recerca]

- 10 minuts presentació + 5 minuts preguntes

Explicació àgil i ràpida. No es donen molts detalls per a cada ítem.

== Estructura

- *Motivació.* Introducció qualitativa a la geometria fractal (anàlogament al primer capítol de la memòria).



  - Objectes geomètrics estranys (Sierpinski, Mandelbrot)

  - Fractals a la natura.

  - Característiques de les fractals.

    - Per a cada característica, un exemple de fractal.

- *Estudi matemàtic.*

  - Enfocament i metodologia.

    - Rigorositat matemàtica. Proposicions, demostracions, teoremes. Durant tota la presenació es menciona que s'ha estudiat la definició formal.

    - Literatura. Llibres d'Edgar i Mandelbrot.

  - Dimensió
    - Definició del concepte comú de dimensió.
  
    - Com s'aplica el concepte de dimensió a les fractals.

  - Sistemes de funcions iterades. L'expressió matemàtica de la recursivitat.

- *Generació de fractals.*

  - Fractals lineals.

    - Algorismes recursius. Complicació de traduir les construccions geomètriques a algorismes (generar fractals no és trivial!)

    - Iteracions. Límit a l'infinit impossible.

    - Implementació dels algorismes amb Typst.

  - Conjunt de Mandelbrot.

    - Necessitat d'alt rendiment. Exploració immersiva.

    - WebGL. Ús de la targeta gràfica. Paral·lelisme. #emoji.warning

    - Interfície d'usuari amb Astro i TypeScript.

 - *Conclusions.*

  - Base matemàtica més complicada que s'esperava, però satisfactòria. Encara hi ha molt per descobrir. Útil per a estudis posteriors.

  - Hi ha més possibilitats de millora en la generació del conjunt de Mandelbrot. La formalització de la recursivitat.

  