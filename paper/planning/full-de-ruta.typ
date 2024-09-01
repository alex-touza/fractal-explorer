#set text(font: "New Computer Modern", lang: "ca")

= Estructura detallada del Treball de Recerca

== Objectiu principal

Descobrir la base matemàtica dels fractals: quins hi ha, per què fan les formes que fan i com es poden representar.

== Àmbits del treball

- *Matemàtica avançada.* Anàlisi dels fractals; per què fan les formes que fan; d'on venen, quins elements matemàtics utilitzen.

  - Topologia.

  - Geometria.

- *Algorísmia.* Anàlisi dels algoritmes de representació de fractals.

- *Programació web.* Mostrar els fractals i informació sobre ells en un suport web interactiu.


== Fractals

L'explicació dels fractals no s'ha de limitar a exposar les fórmules que els generen, sinó que també ha d'aprofundir en què és el que està passant realment. Per exemple, https://medium.com/@atondelier/back-to-webgl-with-the-mandelbrot-set-2840c865113e

https://www.fractal.garden/mandelbrot

- Fractal de Newton

- Conjunt de Mandelbrot

- Conjunt de Julia

- Atractor de Lorentz (explicar també el seu context, i.e. la teoria del caos)

== Estudi teòric dels fractals
- http://www.numdam.org/article/ASENS_1985_4_18_2_287_0.pdf
- https://users.math.yale.edu/public_html/People/frame/Fractals/
(vegeu `bib.yaml` per veure)

La font principal per a la part teòrica serà el llibre Fractal Geometry: Mathematical Foundations and Applications de Kenneth Falconer, ja que té un capítol sencer dedicat a la base matemàtica necessària per entendre el desenvolupament matemàtic dels fractals.

== Representació dels fractals
No limitar-se a mostrar els fractals, sinó oferir una immersió tant visual com matemàtica en ells; això és el que afegeix la meva part pràctica a la resta de múltiples representacions de fractals.

Estudi anterior de la complexitat temporal i lineal dels algoritmes per representar-los.

=== Entorn
La representació es farà en una pàgina web. Això pot semblar no tant formal o rigorós com utilitzar llenguatges com Python o C++ i fer-ho localment, però d'aquesta forma la representació es pot dur a terme a qualsevol dispositiu. A més, la interacció amb l'usuari i el disseny de la interfície són més fàcils de desenvolupar en un entorn web.

Es farà en TypeScript, ja que la comprovació estàtica de tipus és indubtablement millor.

=== Mètode de generació dels gràfics

He explorat Three.js, però Utilitzar Three.js per a una representació plana pot afectar el rendiment, així que he cercat altres _frameworks_ per a dues dimensions. He explorat l'ús de Pixi.js, que sembla que és el més utilitzat. Aquest, però, no està del tot adaptat per a ser usat per a un renderitzat pixel per pixel.

És important que la representació dels fractals utilitzi els mètodes més eficients. Per aquest motiu, potser no és adequat l'ús d'una llibreria. El cert _overhead_ que afegeixen les llibreries com Pixi.js fa pensar que* la millor opció és utilitzar directament la API de WebGL* (també hi ha WebGPU, que aprofita la potència de les targetes gràfiques més modernes, però la seva compatibilitat és reduïda). A més, el fet de fer-ho tot des de zero també és una forma d'aprendre més.


