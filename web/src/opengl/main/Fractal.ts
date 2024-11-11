import { shaderTypes } from '../shaderTypes.ts';
import type { FractalInfo } from '@data/fractal.ts';
import { Uniform1f, Uniform2f, type Uniforms } from '@opengl/main/Uniforms.ts';
import { DefaultAction } from '@data/types.ts';

let displayWidth: number, displayHeight: number;

export interface FractalDataset extends DOMStringMap {
	zoom: string;
	posX: string;
	posY: string;
}

export interface FractalCanvas<Dataset extends FractalDataset = FractalDataset>
	extends HTMLCanvasElement {
	dataset: Dataset;
}

const ZOOM_FACTOR = 3 / 4;

export abstract class Fractal<Dataset extends FractalDataset = FractalDataset> {
	public id: string;
	public info: FractalInfo;

	public context: WebGL2RenderingContext | null = null;
	public canvas: FractalCanvas<Dataset> | null = null;
	public program: WebGLProgram | null = null;
	public shaders: [keyof typeof shaderTypes, string][];
	public lastDraw: number = -1;

	protected uniforms: Uniforms[];

	protected attributes: Map<string, GLint> = new Map();

	protected constructor(
		id: string,
		info: FractalInfo,
		shaders: [keyof typeof shaderTypes, string][],
		uniforms: Uniforms[] = [],
	) {
		this.id = id;
		this.info = info;
		this.shaders = shaders;
		this.uniforms = [
			new Uniform2f('uResolution', () => [
				this.context!.canvas.width,
				this.context!.canvas.height,
			]),
			new Uniform1f('uZoom', () => [parseFloat(this.canvas?.dataset.zoom!)]),
			new Uniform2f('uPosition', () => [
				parseFloat(this.canvas?.dataset.posX!),
				parseFloat(this.canvas?.dataset.posY!),
			]),
			...uniforms,
		];
	}

	protected screenToPlane(x: number, y: number): [x: number, y: number] {
		return [
			(((x / this.canvas?.width!) * 2 - 1) *
				(this.canvas?.width! * parseFloat(this.canvas?.dataset.zoom!))) /
				2 +
				parseFloat(this.canvas?.dataset.posX!),
			(((y / this.canvas?.height!) * 2 - 1) *
				(-this.canvas?.height! * parseFloat(this.canvas?.dataset.zoom!))) /
				2 +
				parseFloat(this.canvas?.dataset.posY!),
		];
	}

	private loadShader(shaderType: keyof typeof shaderTypes, source: string) {
		if (this.context === null) throw 'context is null';

		const shader = this.context.createShader(
			shaderTypes[shaderType].constant(),
		)!;

		this.context.shaderSource(shader, source);

		this.context.compileShader(shader);

		if (!this.context.getShaderParameter(shader, this.context.COMPILE_STATUS)) {
			alert(
				`An error occurred compiling the shaders: ${this.context.getShaderInfoLog(shader)}`,
			);
			this.context.deleteShader(shader);
			return null;
		}

		return shader;
	}

	// https://webgl2fundamentals.org/webgl/lessons/webgl-resizing-the-canvas.html
	protected resizeCanvas() {
		console.log('resizeCanvas');
		if (!this.canvas) throw 'canvas is null';

		const needResize =
			this.canvas.width !== displayWidth ||
			this.canvas.height !== displayHeight;

		if (needResize) {
			this.canvas.width = displayWidth;
			this.canvas.height = displayHeight;
		}

		this.context!.viewport(0, 0, displayWidth, displayHeight);

		return needResize;
	}

	protected newAttribute(name: string): GLint {
		const loc = this.context!.getAttribLocation(this.program!, name);
		if (loc === null) throw 'location is null';

		this.attributes.set(name, loc);

		return loc;
	}

	private onResize(entries: ResizeObserverEntry[]) {
		console.log('resizeObserver triggered');
		for (const entry of entries) {
			let width;
			let height;
			let dpr = window.devicePixelRatio;
			if (entry.devicePixelContentBoxSize) {
				// NOTE: Only this path gives the correct answer
				// The other paths are imperfect fallbacks
				// for browsers that don't provide anyway to do this
				// @ts-ignore
				width = entry.devicePixelContentBoxSize[0].inlineSize;
				// @ts-ignore
				height = entry.devicePixelContentBoxSize[0].blockSize;
				dpr = 1; // it's already in width and height
			} else if (entry.contentBoxSize) {
				if (entry.contentBoxSize[0]) {
					width = entry.contentBoxSize[0].inlineSize;
					height = entry.contentBoxSize[0].blockSize;
				} else {
					// @ts-ignore
					width = entry.contentBoxSize.inlineSize;
					// @ts-ignore
					height = entry.contentBoxSize.blockSize;
				}
			} else {
				width = entry.contentRect.width;
				height = entry.contentRect.height;
			}
			displayWidth = Math.round(width * dpr);
			displayHeight = Math.round(height * dpr);
		}

		requestAnimationFrame(() => this.draw());
	}

	public zoom(x: number, y: number, zoomIn: boolean) {
		if (!this.canvas) return;

		let dataset = this.canvas!.dataset;

		let currentZoom = parseFloat(dataset.zoom);
		if ((!zoomIn && currentZoom > 0.005) || (zoomIn && currentZoom < 1e-8))
			return;

		let zoomDelta = zoomIn ? ZOOM_FACTOR : 1 / ZOOM_FACTOR;

		const coords = this.screenToPlane(x, y);
		const newZoom = zoomDelta * currentZoom;

		dataset.zoom = String(newZoom);

		let planeWidth = this.canvas.width * newZoom;
		let planeHeight = this.canvas.height * newZoom;

		console.log(planeHeight, coords);

		dataset.posX = String(
			coords[0] - (x / this.canvas.width - 0.5) * planeWidth,
		);

		dataset.posY = String(
			coords[1] -
				((this.canvas.height - y) / this.canvas.height - 0.5) * planeHeight,
		);

		requestAnimationFrame(() => this.draw());
	}

	public abstract home(): void;

	public begin(canvas: FractalCanvas<Dataset>) {
		this.canvas = canvas;

		this.context = this.canvas.getContext('webgl2')!;
		this.program = this.context!.createProgram();

		if (!this.program || !this.context) throw 'program or context null';

		this.canvas.addEventListener('wheel', (event) => {
			this.zoom(event.clientX, event.clientY, event.deltaY < 0);
		});

		this.canvas.addEventListener('mousemove', (event) => {
			if (event.buttons) {
				this.canvas!.dataset.posX = String(
					parseFloat(this.canvas?.dataset.posX!) -
						event.movementX * parseFloat(this.canvas?.dataset.zoom!),
				);
				this.canvas!.dataset.posY = String(
					parseFloat(this.canvas?.dataset.posY!) +
						event.movementY * parseFloat(this.canvas?.dataset.zoom!),
				);
				requestAnimationFrame(() => this.draw());
				console.log('moved');
			}
		});

		const resizeObserver = new ResizeObserver(this.onResize.bind(this));

		resizeObserver.observe(canvas, { box: 'content-box' });

		window.addEventListener('fractal-interact', (event) => {
			console.log(event);
			let action = parseInt((event as CustomEvent).detail) as DefaultAction;
			let center = [this.canvas?.width! / 2, this.canvas?.height! / 2] as [
				number,
				number,
			];
			switch (action) {
				case DefaultAction.ZOOM_IN:
					this.zoom(...center, true);
					break;
				case DefaultAction.ZOOM_OUT:
					this.zoom(...center, false);
					break;
				case DefaultAction.HOME:
					this.home();
					requestAnimationFrame(() => this.draw());
			}
		});

		for (let [type, source] of this.shaders) {
			let shader = this.loadShader(type, source);
			if (!shader) throw 'no shader';
			this.context!.attachShader(this.program!, shader);
		}

		this.context.linkProgram(this.program);

		if (
			!this.context.getProgramParameter(this.program, this.context.LINK_STATUS)
		) {
			alert(
				`An error occurred linking the program:  ${this.context.getProgramInfoLog(this.program)}`,
			);
			this.context.deleteProgram(this.program);
		}
		for (let uniform of this.uniforms) {
			uniform.locate(this);
		}
	}

	protected assignUniforms() {
		for (let uniform of this.uniforms) {
			uniform.set(this);
		}
	}

	public draw() {
		if (this.context === null) throw 'context null';
		this.lastDraw = Date.now();
		this.resizeCanvas();

		this.context.clearColor(0, 0, 0, 0);
		this.context.clear(this.context.COLOR_BUFFER_BIT);

		this.context.useProgram(this.program);
	}
}
