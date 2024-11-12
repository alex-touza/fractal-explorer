import { MandelbrotFractal, type MandelbrotDataset } from './mandelbrot.ts';
import { type FractalCanvas } from '../Fractal.ts';

const fractal = new MandelbrotFractal();

const canvas = document.getElementById(
	'canvas',
) as FractalCanvas<MandelbrotDataset>;

fractal.begin(canvas);

fractal.frame();
