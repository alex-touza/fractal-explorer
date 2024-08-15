import type { FractalView } from '@data/types.ts';

/*

 */
abstract class Fractal implements FractalView {
	name: string;
	id: string;
	descr: string;
	thumbnailPath: string;

	constructor(name: string, id: string, descr: string, thumbnailPath: string) {
		this.name = name;
		this.id = id;
		this.descr = descr;
		this.thumbnailPath = thumbnailPath;
	}
}
