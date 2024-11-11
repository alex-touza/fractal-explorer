import { MandelbrotFractal, type MandelbrotDataset } from './mandelbrot.ts';
import { type FractalCanvas } from '../main/Fractal';

const fractal = new MandelbrotFractal();

const canvas = document.getElementById(
	'canvas',
) as FractalCanvas<MandelbrotDataset>;

fractal.begin(canvas);

fractal.frame();
