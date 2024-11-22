#import "../environments.typ": *
#import "../utilities.typ": *
#import "../../meta.typ": *
#import "../shortcuts.typ": *
#import "@preview/cetz:0.2.2": canvas, draw
#import "@preview/dashy-todo:0.0.1": todo
#import "@preview/cetz:0.2.2": canvas, draw, plot
#import "@preview/suiji:0.3.0": *

= Introducció a la geometria fractal

En aquest primer capítol, s'exposarà la història de la geometria fractal, des de l'aparició de les corbes no derivables fins els primers objectes fractals. També es discutiran les característiques associades a aquestes formes.

/*
En aquest primer capítol, s'exposarà el concepte de _fractal_ i es definirà de forma matemàtica, explorant els diferents significats que s'han associat a aquest terme al llarg de les dècades. Després, es definiran les diferents _dimensions_ que es poden calcular d'aquest objecte matemàtic.
*/

#def[Veïnat d'un punt][
  Un _veïnat d'un punt_ $p$ d'un espai topològic $(X, tau)$ (@def-espai-topològic) és un subconjunt $V$ de $X$ que conté un conjunt obert $U$ que conté $p$. Simbòlicament, $p in U subset.eq V subset.eq X$.
] <def-veïnat>



#def[Funció analítica][
  Sigui $I$ un conjunt obert. Una funció $f: RR -> RR$ és _analítica_ en $I$ si per qualsevol punt $a$ del conjunt existeix un veïnat $J$ de $a$ (@def-veïnat) tal que $f$ es pugui expressar com una sèrie de potències que convergeixi a $a$:

  $
  f(x) = sum^infinity_(i=0) c_i (x - a)^n
  $

  on $c_i$ són els coeficients de cada terme de la sèrie. Simbòlicament,

  $
  forall a in I med (exists J : a in J : forall x in J med  f(x) = sum^infinity_(i = 0) c_i (x-a)^n "és convergent a" a )
  $


  Evidentment, si la funció no és contínua en $a$, aleshores tampoc és analítica en $a$. Per tant, una funció com $g(x) = x^2/(x-1)$ és analítica en $RR - {1}$.

  Si per al punt $a$ la funció no convergeix a cap nombre o convergeix a un valor diferent de $f(a)$, aleshores la funció tampoc és analítica. Per exemple, la funció $f(x)= sum^infinity_(n=1) x^n$ no és analítica perquè la sèrie no és convergent, però les funcions trigonomètriques bàsiques, $sin$ i $cos$, estan definides amb sèries convergents:

  $
  sin(x) = sum^infinity_(i = 0) (-1)^n (x^(2n+1))/(2n + 1)!, wide cos(x)=sum^infinity_(i = 0) (-1)^n (x^(2n))/(2n!)
  $

  La demostració de la convergència d'aquestes funcions es proposa com un exercici per al lector.#footnote[
    #printable-hyperlink("Demostració per al sinus.", "https://proofwiki.org/wiki/Sine_Function_is_Absolutely_Convergent")
  ]

  
] <def-funcio-analitica>

#def[Derivable gairebé pertot][
  Una funció $f$ és _derivable gairebé pertot_ si el conjunt de punts $A = {x : exists.not f'(x)} $ (els punts en què la derivada no existeix) és finit o comptable./*#footnote([
    Formalment, és quan el conjunt de punts no derivables és de mesura nul·la. Tots els conjunts finits o comptables són nuls, però també existeixen conjunts infinits o no comptables que són nuls, així que la definició exposada és incompleta. S'ha optat per simplificar la definició i així evitar introduir el concepte de mesura a aquest primer capítol.
  ])*/

  Anàlogament, una funció $f$ és _no derivable gairebé pertot_ si el conjunt de punts $B = {x : exists f'(x)}$ (els punts en què la derivada existeix) és finit o comptable.
] <def-derivable-gairebe-pertot>
/*
#def[Conjunt dens][
  Donat els conjunts $A$ i $X$, $A$ és un conjunt dens a $X$ si compleix alguna d'aquestes condicions (només es llisten les rellevants):
  
  #enum(numbering: "(I)")[
    El subconjunt tancat de $X$ (informalment, que conté el seu contorn) més petit contenint $A$ és $X$ mateix.
  ][
    Existeix una intersecció entre $A$ i tots els subconjunts oberts (és a dir, que no contenen el seu contorn) no buits de $X$.
  ][
    Qualsevol punt de $X$ pertany a $A$ o és un punt límit de $A$.
  ]
]
*/

== Origen de la geometria fractal


=== Riemann, Weierstrass i les corbes no derivables
/*
Al llarg de la història de les matemàtiques, s'han formulat diversos conjunts i formes geomètriques que avui dia considerem fractals.
*/
Les matemàtiques avançades sovint es centren en funcions derivables, és a dir, aquelles formes en què és possible dibuixar una recta tangent a qualsevol punt: molts dels conceptes de càlcul depenen de la derivabilitat de l'objecte matemàtic que s'estudia.

// Aquesta concepció prové originalment de Isaac Newton

El càlcul, una de les branques més importants de les matemàtiques, concebut de forma simultània per Newton i Leibniz, es basava en la suposició que, donada una funció analítica $f$ (@def-funcio-analitica) que és contínua a l'interval $[a,b]$, $f$ és derivable gairebé pertot punt dins $(a,b)$ (@def-derivable-gairebe-pertot). Tots els grans matemàtics d'abans del segle XX, com Gauss i Cauchy, suposaven que això era cert, o almenys no van dir el contrari.

El matemàtic i físic francès André-Marie Ampère va fer una demostració ---no gaire rigurosa--- d'aquesta conjectura, basant-se en un teorema sobre les corbes contínues (@teorema_ampere) @Kucharski2022. 

#theorem[Teorema d'Ampère de les corbes contínues#footnote[
  No confondre amb les lleis de força i circuits d'Ampère.
]][
  Tota corba contínua ha de tenir seccions que siguin creixents, decreixents o completament horitzontals.
] <teorema_ampere>


El teorema d'Ampère, tanmateix, no considerava el cas que aquestes seccions siguin infinitament petites---és a dir, assumeix que una corba infinitament rugosa és impossible.


Durant la dècada de 1860, Bernhard Riemann va proposar una funció analítica contínua que no era, suposadament, derivable enlloc. Es defineix amb l'expressió (@fig-grafica-riemann, als annexos)

$
R(x)=sum^infinity_(n=1) sin(n^2 x)/n^2
$




Tanmateix, Riemann no va demostrar que fos així. Durant el segle XX s'ha comprovat que la funció de Riemann sí que és derivable en punts concrets @Hardy1916 @Gerver1969 @Gerver1971: per exemple, Hardy va provar la derivabilitat per a punts $r pi$ tal que $r$ és nombre irracional i Gerver ho va fer en punts tals que la variable independent pren un valor de $pi$ multiplicat per una fracció de nombres enters senars. Així doncs, com que el conjunt de punts en què la derivada existeix és comptable, la funció de Riemann és no derivable gairebé pertot.

Finalment, la primera funció que es va demostrar que no era derivable en cap punt, i que per tant falsava el teorema d'Ampère va ser proposada per Karl Weierstrass el 1872:

$
W(x)=sum^infinity_(n=1) a^n cos(b^n x pi)
$

tal que $0 < a < 1$, $b$ és un enter positiu i $display(a b > 1 + 3/2pi)$.


La funció de Weierstrass (@fig-grafica-weierstrass, als annexos) va tenir tal impacte en les matemàtiques de l'època, que Poincaré es va referir a aquesta funció com un "monstre" i un "ultratge contra el sentit comú". Lògicament, els matemàtics ja coneixien funcions que tenien un conjunt de punts aïllats no derivables; però l'existència d'una funció no derivable gairebé enlloc implicava que la proposició en què es basava el càlcul era falsa ---que qualsevol funció contínua és derivable gairebé pertot---, per culpa de les definicions imprecises i demostracions que abusaven de la intuïció.

Aquesta fita va ser una autèntica lliçó per als matemàtics; mostrava com d'important era mantenir la rigorositat i no fer masses suposicions de les quals més tard ens podem penedir. En tot cas, la funció de Weierstrass obria les portes a un nou món matemàtic, el món de les corbes infinitament rugoses./*; és a dir, les fractals. De fet, avui dia la seva gràfica es consideraria un objecte fractal. */

=== Cantor, Koch i la mirada a l'infinit

La funció de Weierstrass va començar a despertar la curiositat en el "món rugós"; durant les següents dècades, es van idear nous objectes matemàtics que van anar construint la geometria fractal com la coneixem avui dia.

Georg Cantor, el pare de la teoria de conjunts, qui va assistir a les classes de Weierstrass, va crear el 1883 una funció $psi$ amb unes característiques molt interessants, definida a l'interval $[0, 1]$: conté diverses simetries entre punts i és derivable gairebé pertot, excepte un conjunt de punts molt concrets, que anomenem conjunt de Cantor (#pritable-doclink(<cap-cantor>)).

A principis del segle XX, el 1904 Hedge von Koch va proposar una altra forma de trobar una corba contínua però no derivable. A diferència de Weierstrass, que ho feia de forma totalment analítica, l'enfocament de Koch era purament geomètric, de forma que la no derivabilitat de l'objecte és òbvia (encara que no és trivial demostrar-la formalment). Es tracta de la corba de Koch, que unida amb dos més objectes iguals, forma el floc de neu de Koch. 

Aquest últim objecte es construeix amb un algorisme geomètric recursiu, és a dir, l'objecte és conté a si mateix. D'aquesta manera, la corba de Koch és el límit a l'infinit de realitzar l'algorisme infinites vegades (simbòlicament, $C = lim_(n->+infinity) C_n$). Aquest mètode de generació s'anomena sistemes de funcions iterades (IFS), que s'estudia en detall més endavant (#pritable-doclink(<cap-ifs>)).
/*
$
psi'(x) = cases(0 wide& "si" x in.not C,+infinity & "si" x in C) 
$
*/

El 1915, va aparèixer una altra fractal construït amb el mateix mètode, el conegut triangle de Sierpiński. Aquest objecte és encara més interessant, perquè es pot generar amb molts algorismes diferents.


Els objectes matemàtics mencionats en aquest apartat (la funció de Cantor, el conjunt de Cantor i la corba de Von Koch) requereixen un desenvolupament més profund; es defineixen a l'apartat corresponent.



=== Einsein, Perrin i el moviment brownià

El moviment brownià es va concebre inicialment com el conjunt de trajectòries que fan les partícules suspeses en un fluid. S'atribueix a Albert Einstein la matematització d'aquest fenomen. En un article de 1905, va exposar com una expressió per la difusió molecular mitjançant un model matemàtic probabilístic i va predir que les interaccions entre molècules diluïdes causen moviments caòtics. El 1909, el físic francès Jean Perrin va dur a terme una sèrie d'experiments per demostrar-ho empíricament.

#figure(caption: [Exemple d'una possible trajectòria browniana. En negre, la trajectòria que es mesuraria en un interval de temps $Delta t_a$, i en gris, la trajectòria que es mesuraria en uns intervals $Delta t_b$, on $Delta t_b < Delta t_a$.])[
  #canvas(
    {
      import draw: * 

      let draw_point(x, y, name) = {
        circle((x, y), radius: .25, name: name)
        content((x, y), text(10pt, name))
      }

      draw_point(-5, 0, "A")
      draw_point(6, -2, "B")

      line("A", "B")

      set-style(stroke: gray.lighten(40%))
      
      line("A", (-4, 2))
      line((-4, 2), (-2, -2))
      line((-2, -2), (2, 1))
      line((2, 1), (4, -2))
      line( (4, -2), "B")
      


    }
  )
] <fig-mov-brownia>

Com mostra la @fig-mov-brownia, resulta impossible determinar la trajectòria en un moviment brownià perquè, a mesura que augmenta la precisió, augmenta la incertesa de la posició del cos. Per tant, com explica Perrin, el moviment brownià és un altre exemple de rugositat infinita i de corba no derivable, ja que intentar traçar una recta tangent a un punt de la trajectòria és impossible @Bigg2011.

Fins al dia d'avui, s'han trobat aplicacions de les dinàmiques brownianes més enllà de l'estudi de la difusió molecular, com el moviment d'estrelles dins d'una galàxia.

=== Mandelbrot i les fractals financeres


El matemàtic polonès Benoît Mandelbrot (1924#{sym.dash.en}2010) també va començar a observar "rugositats" a una multitud d'àrees de la realitat. Les seves investigacions consistien en estudiar el comportament de les fluctuacions de diferents variables, començant pels mercats financers i els preus de productes com el cotó i el blat, fins les inundacions del riu Nil. Durant els seus primers estudis, es va adonar que resultats exactes requerien considerar una "variància infinita", ben lluny de les aproximacions poc realistes dels models de l'època. @Gomory2010

Aquesta nova perspectiva es va veure reflectida en el seu article _How Long is the Coast of Britain? Statistical Self-Similarity and Fractional Dimension_ (en català, _Quina és la longitud de la costa de Gran Bretanya? Autosimilitud estadística i dimensió fraccionària_) @Mandelbrot1967, en què estudiava la rugositat ("el grau de complicació") de les corbes geogràfiques. Mandelbrot va proposar una dimensió $D$ que mesura aquesta complicació.

L'objectiu de Mandelbrot era mirar la realitat d'una forma diferent; deixar enrere les imprecisions i convencions del càlcul i tractar el món tal com és: rugós, imperfecte i no derivable. El polonès criticava la certa obsessió dels seus companys de professió per l'abstracció i el formalisme, que no permetia a les matemàtiques poder reflectir el món adequadament.

Tots els objectes matemàtics exposats fins ara no tenien una categoria en comú; eren només "monstres", com deia Poincaré, que tenien propietats estranyes. /*Els lectors s'hauran adonat que, des del començament d'aquest capítol sobre la història de la geometria fractal, encara no hem fet servir el terme _fractal_---*/I és que no va ser fins el 1975 quan Mandelbrot va introduir els termes _fractal_ i _objecte fractal_, permetent als matemàtics finalment referir-se aquestes formes geomètriques. Per aquest motiu, sovint es parla de Mandelbrot com al "pare dels fractals".

Tota la seva feina va quedar exposada el 1982 en el seu llibre _The Fractal Geometry of Nature_ ---que és, de fet, una de les fonts principals d'aquest treball.


== La geometria fractal a la natura

La geometria fractal és un dels camps de les matemàtiques que més ha despertat la curiositat del públic per la seva bellesa, així com per la seva omnipresència a la natura. Es solen associar les fractals amb formes com flocs de neu (@floc_de_neu) i cols autosimilars (@romanesco), però es poden trobar característiques fractals a molts altres racons del món real.

#grid(columns: (1fr, 1fr), gutter: 2em)[
  #figure(caption: [Floc de neu. _Domini públic._])[
    #image("../images/floc de neu.png", height: 130pt)
  ] <floc_de_neu>
][
  #figure(caption: [
    Patrons fractals en un cristall congelat. _By Schnobby - Own work, CC BY-SA 3.0, \<https://commons.wikimedia.org/w/index.php?curid=19055302>_
  ])[
    #image("../images/cristall congelat (Schnobby).png", height: 130pt)
  ] <cristall_congelat>
][
  #figure(
    caption: [
      Un romanesco, un tipus de col que presenta autosimilitud. _Ioangogo - Own work, CC BY-SA 4.0, \<https://commons.wikimedia.org/w/index.php?curid=39553243>_
    ]
  )[
    #image("../images/romanesco (loangogo).png", width: 200pt, height: 130pt)
  ] <romanesco>
][
  #figure(caption: [
    Dendrita d'òxid de manganès formada en pedra calcària. Escala en mil·límetres. _Mark A. Wilson (Department of Geology, The College of Wooster)._
  ])[
    #image("../images/dendrites (Wilson).png", width: 200pt, height: 130pt)
  ] <dendrita>
]

Les fractals són una bona representació de la realitat. Si bé la geometria euclidiana, a la qual estem acostumats, acaba sent llisa quan ens hi apropem prou, això no representa amb precisió el món natural. La geometria fractal té un enfocament diferent i considera que les formes no són llises, sinó infinitament rugoses. Aquesta postura més realista i propera al món real contrasta amb la moltes altres branques de les matemàtiques, que són més difícils de relacionar directament amb la natura. Això, a més, fa que la geometria fractal sigui un d'aquells conceptes matemàtics que, quan hom els coneix amb profunditat, els observa a tota la realitat.

Ara bé, cal remarcar que són representacions: les formes fractals, també, són una aproximació de la realitat, ja que no existeix realment la rugositat infinita (una mateixa forma no es pot repetir). Els fenòmens que es poden veure a les figures es considera que exhibeixen un comportament fractal, però no es poden anomenar fractals estrictament parlant.

Tanmateix, com Mandelbrot aclareix al principi del seu llibre, la geometria fractal no es basa en fenòmens naturals. Com Mandelbrot mateix explica, aquesta branca de les matemàtiques va ser una conseqüència dels "monstres" concebuts a finals del segle XIX, exposats a la secció anterior. I aquestes matemàtiques són les que s'exploraran al llarg d'aquest treball.


== Característiques de les fractals


El terme _fractal_ (que en català és un mot femení), com s'ha mostrat, va ser creat per Mandelbrot, a partir de la paraula llatina _frāctus_. Si bé inicialment va definir el terme com un conjunt en què la dimensió de Hausdorff és inferior a la dimensió topològica, el consens actual és que no s'hauria de definir concretament, sinó associar-hi unes propietats @falconer @Mandelbrot1987:

- *Irregularitat geomètrica.* Alguns objectes fractals no es poden descriure completament a partir de la geometria euclidiana convencional, si no és amb una definició recursiva.

- *Autosimilitud exacta o parcial.* Com a conseqüència de la propietat anterior, moltes fractals es contenen a si mateixes, és a dir, que si desenvolupem o representem la seva definició podem trobar còpies de si mateixa. Això és evident en el cas de definicions clarament recursives, com el triangle de Sierpinski, però també es troba en fractals definides de formes diferents, com el conjunt de Mandelbrot, on aquesta autosimilitud és absolutament inesperada.

  També hom pot obtenir autosimilitud estadística, que no es tracta d'una semblança geomètrica, sinó en les seves propietats. Un exemple clàssic és la silueta d'una costa: cada porció de l'objecte, sigui gran o petita, té una rugositat semblant a la resta encara que tingui forma diferent.

- *Estructura detallada minúscula.* Les formes geomètriques convencionals, si ens hi apropem suficient, acaben semblant llises. En canvi, els fractals tenen una rugositat que sovint és infinita.

  Aquesta rugositat es mesura amb dimensions fractals (#pritable-doclink(<cap-dimensio-fractal>)), com la dimensió de Hausdorff i la dimensió autosimilar.

- *Definició simple.* Moltes fractals tenen definicions molt senzilles. Això, considerant les propietats anteriors, és sorprenent. /*Alguns fractals s'obtenen amb un algoritme recursiu, de manera que successives iteracions d'aquest porten a una aproximació més exacta de la fractal.*/

  Aquesta característica resulta, a la vegada, útil i problemàtica. És útil perquè facilita molt la seva representació ---són increïblement senzilles de generar amb un llenguatge de programació---, però és problemàtica perquè aleshores és més complicat trobar l'explicació de les formes que es troben a fractals com la de Mandelbrot o Newton.

- *Dificultats en la mesura.* Sovint resulta inútil realitzar mesures comunes com la llargada o l'àrea en els objectes fractals, ja que aquestes són o bé impossibles de fer o resulten en valors nuls o infinits, en el cas de les corbes fractals. Seguint l'exemple anterior, la llargada d'una costa augmenta sense límit quan augmentem la precisió.

El terme s'utilitza de forma àmplia per designar qualsevol forma geomètrica que presenti alguna de les propietats anteriors, especialment l'autosimilitud i l'estructura detallada minúscula.

//A la @cap-exemple-gen-fractal teniu un exemple de fractal autosimilar i amb detall infinit, generat iterativament.

#figure(caption:[Un segment qualsevol és autosimilar, però no té estructura detallada infinita, així que no es consideraria un fractal.] ,
  box(
    height: 20pt,
    align(horizon,
      canvas({
        import draw: *
      
        line((-3, 0), (3, 0))

        for i in range(-3, 4) {
          line((i, 0.1), (i, -0.1))
        }
      })
    )
  )
)

#figure(caption: [Una corba fractal té llargada infinita; ampliant la imatge, observaríem que la llargada real no és un nombre finit.],
  box(
    height: 50pt,
    align(horizon,
      canvas({
        import draw: *

        let points = ()
        let rng = integers(gen-rng(100), low: -8, high: 8, size: 130).at(1)
        
        for (i, n) in rng.enumerate() {
          if i == rng.len() - 1 {
            continue
          }

          line((i / 10, n /10), ((i+1) / 10, rng.at(i+1) / 10))
        }

          
        
      })
    )
  )
)

/*Considerem una circumferència $c_0$ de radi $r$ a $RR^2$. Aleshores, el conjunt de punts de $c_0$ s'obté de l'expressió:

$

c_0 colon  cases(
  x = r cos(theta),
  y = r sin(theta)
) => c_0 = {(r cos(theta), r sin(theta)) : theta in [0,2pi)}
$

on $r$ és una constant i $theta$ és el paràmetre de la circumferència.

Considerem la funció $ f(x) = x / 10 $



#figure(caption: [La circumferència $c_0$ amb radi $r$.])[
  #canvas({
    import draw: *

    circle((0, 0), radius: 2.5)

    line((0,0), (2.5, 0))
  })
]

#figure(caption: [Aquest objecte està format per ],
  box(
    height: 150pt,
    align(horizon,
      canvas({
        import draw: *

        circle((-3, 0), radius: 2.5)
        circle((-3, 0), radius: 2.4, stroke: gray)
        circle((-3, 0), radius: 2.3, stroke: gray.lighten(50%))
        circle((-3, 0), radius: 2.2, stroke: gray.lighten(80%))
        

        for i in range(1, 100, step: 4) {
          circle((3, 0), radius: 2.5 - i / 20)
        }

        circle((3, 0), radius: 0.1)
        circle((3, 0), radius: 0.02)
      })
    )
  )
)
*/