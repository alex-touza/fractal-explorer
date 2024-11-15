import { MandelbrotFractal } from './mandelbrot.ts';
import { type FractalCanvas } from '../Fractal.ts';

const fractal = new MandelbrotFractal();

const canvas = document.getElementById('canvas') as FractalCanvas;

fractal.begin(canvas);

fractal.frame();
