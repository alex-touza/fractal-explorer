import type { FractalView } from './types';
/*
https://users.math.yale.edu/public_html/People/frame/Fractals/MandelSet/welcome.html
https://ui.adsabs.harvard.edu/abs/2003math......5399D/abstract
*/
export const fractals: FractalView[] = [
	{
		name: 'Conjunt de Mandelbrot',
		descr:
			"Conjunt de punts del pla complex pels quals una funció no divergeix a l'infinit quan s'itera.",
		thumbnailPath: 'mandelbrot.webp',
		id: 'mandelbrot',
	},
	{
		name: 'Fractal de Newton',
		descr:
			"Frontera del pla complex que resulta del mètode de Newton per trobar arrels d'una funció.",
		thumbnailPath: 'newton.png',
		id: 'newton',
	},
	{
		name: 'Corbes de Koch',
		descr: '',
	},
	{
		name: 'Triangle de Sierpinski',
		descr: '',
	},
	{
		name: 'Figures de Lichtenberg',
		descr: '',
	},
	{
		name: 'Atractor de Lorentz',
	},
];

export const getFractal = (route: string) =>
	fractals.find((fractal) => fractal.id == route);
