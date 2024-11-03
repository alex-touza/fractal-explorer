import type { FractalInfo } from '@data/fractal.ts';

/*
https://users.math.yale.edu/public_html/People/frame/Fractals/MandelSet/welcome.html
https://ui.adsabs.harvard.edu/abs/2003math......5399D/abstract
*/
export const mandelbrot = {
	name: 'Conjunt de Mandelbrot',
	id: 'mandelbrot',
	descr:
		"Conjunt de punts del pla complex pels quals una funció no divergeix a l'infinit quan s'itera",
	thumbnailPath: 'mandelbrot.webp',
};

export const helloWorld = {
	name: 'Hello World',
	id: 'helloWorld',
	descr: '',
	thumbnailPath: '',
};

export const fractals: FractalInfo[] = [
	mandelbrot,
	helloWorld,

	/*{
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
    },*/
];

export const getFractal = (id: string) =>
	fractals.find((fractal) => fractal.id == id);
