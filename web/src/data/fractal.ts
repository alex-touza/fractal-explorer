import type { FractalView } from '@data/types.ts';

type DrawFunction = (canvas: HTMLCanvasElement) => void

/*

 */
export class Fractal implements FractalView {
	name: string;
	id: string;
	descr: string;
	thumbnailPath: string;
	drawFunc: DrawFunction;

	constructor(name: string, id: string, descr: string, thumbnailPath: string, drawFunc: DrawFunction) {
		this.name = name;
		this.id = id;
		this.descr = descr;
		this.thumbnailPath = thumbnailPath;
		this.drawFunc = drawFunc;
	}
}

/*


Fitxa del fractal:

Dimensió

IFS

Sistema de Leidenmeyer

 */