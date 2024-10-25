
// Parella de punts a vector
#let p-to-vec(a, b) = {
  return (b.first() - a.first(), b.last() - a.last())
}

// Suma dels vectors a i b
#let sum-vec(a, b) = {
  return (a.first() + b.first(), a.last() + b.last())
}

// Multiplicació del vector a per un real k
#let fact-vec(a, k) = {
  return (a.first()*k, a.last()*k)
}

// Component horitzontal del vector a
#let x-vec(a) = {
  return (a.first(), 0)
}

// Component vertical del vector a
#let y-vec(a) = {
  return (0, a.last())
}

// Altura per a un triangle equilàter de costat c 
#let h-tri-eq(c) = {
  return calc.sqrt(2) * c / 2
}

// Punt mig entre dos punts
#let average(a, b) = {
  return ((a.first() + b.first()) / 2,  (a.last() + b.last()) / 2,)
}

// Magnitude del vector v
#let magnitude(v) = {
  return calc.sqrt(v.first() * v.first() + v.last() * v.last())
}

// Pendent del vector v
#let slope(v) = {
  return v.last() / v.first()
}

/*****/

#let reg_polygon(n, size) = {
  return range(n).map(i => (size * calc.cos(2*calc.pi*i/n), size * calc.sin(2*calc.pi*i/n)))
}