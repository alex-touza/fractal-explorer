export interface FractalView {
	name: string;
	descr: string;
	thumbnailPath: string;
	id?: string;
}

export interface Fractal extends FractalView {
	sidebar: any; // descripció de les opcions que apareixen a la interfície
}

export type CustomEventType = keyof GlobalEventHandlersEventMap;

export enum DefaultAction {
	ZOOM_IN,
	ZOOM_OUT,
	HOME,
}
