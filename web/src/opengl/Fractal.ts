import { shaderTypes } from './shaderTypes.ts';
import type { FractalInfo } from '@data/fractal.ts';
import { Uniform1f, Uniform2f, type Uniforms } from '@opengl/Uniforms.ts';
import { DefaultAction } from '@data/types.ts';

let displayWidth: number, displayHeight: number;

export interface FractalCanvas extends HTMLCanvasElement {}

const ZOOM_FACTOR = 3 / 4;

export abstract class Fractal {
	public id: string;
	public info: FractalInfo;

	public context: WebGL2RenderingContext | null = null;
	public canvas: FractalCanvas | null = null;
	public program: WebGLProgram | null = null;
	public shaders: [keyof typeof shaderTypes, string][];

	public uResolution: Uniform2f;
	public uPlaneWidth: Uniform1f;
	public uPosition: Uniform2f;

	protected lastDraw: number = -1;

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
		this.uResolution = new Uniform2f('uResolution', () => [
			this.context!.canvas.width,
			this.context!.canvas.height,
		]);
		this.uPosition = new Uniform2f('uPosition', -0.5, 0);
		this.uPlaneWidth = new Uniform1f('uPlaneWidth', 4);
		this.uniforms = [
			this.uResolution,
			this.uPlaneWidth,
			this.uPosition,

			...uniforms,
		];
	}

	protected get planeSize(): [w: number, h: number] {
		return [
			this.uPlaneWidth.value[0],
			(this.uPlaneWidth.value[0] * this.canvas?.height!) / this.canvas?.width!,
		];
	}

	protected screenToPlane(x: number, y: number): [x: number, y: number] {
		const planeSize = this.planeSize;

		return [
			(((x / this.canvas?.width!) * 2 - 1) * planeSize[0]) / 2 +
				this.uPosition.value[0],
			(((y / this.canvas?.height!) * 2 - 1) * -planeSize[1]) / 2 +
				this.uPosition.value[1],
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
		if (!this.canvas) throw 'canvas is null';

		const needResize =
			this.canvas.width !== displayWidth ||
			this.canvas.height !== displayHeight;

		if (needResize) {
			this.canvas.width = displayWidth;
			this.canvas.height = displayHeight;
		}

		this.context!.viewport(0, 0, displayWidth, displayHeight);

		console.log(this.canvas.width, this.canvas.height);

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

		/*
		let currentZoom = parseFloat(dataset.zoom);
		if ((!zoomIn && currentZoom > 0.005) || (zoomIn && currentZoom < 1e-8))
			return;
			*/
		let zoomDelta = zoomIn ? ZOOM_FACTOR : 1 / ZOOM_FACTOR;

		let currentPlaneSize = this.planeSize;

		if (!zoomIn && this.uPlaneWidth.value[0] > 4) return;

		const coords = this.screenToPlane(x, y);
		//const newZoom = zoomDelta * currentZoom;

		//dataset.zoom = String(newZoom);

		this.uPlaneWidth.value = [currentPlaneSize[0] * zoomDelta];

		this.uPosition.value = [
			coords[0] - (x / this.canvas.width - 0.5) * this.uPlaneWidth.value[0],
			coords[1] -
				((this.canvas.height - y) / this.canvas.height - 0.5) *
					this.planeSize[1],
		];

		this.frame();
	}

	public begin(canvas: FractalCanvas) {
		console.log(canvas.width, canvas.height);
		this.canvas = canvas;

		this.context = this.canvas.getContext('webgl2')!;
		this.program = this.context!.createProgram();

		if (!this.program || !this.context) throw 'program or context null';

		this.canvas.addEventListener('wheel', (event) => {
			this.zoom(event.clientX, event.clientY, event.deltaY < 0);
		});

		this.canvas.addEventListener('mousemove', (event) => {
			if (event.buttons) {
				this.uPosition.value = [
					this.uPosition.value[0] -
						(event.movementX * this.uPlaneWidth.value[0]) / this.canvas?.width!,
					this.uPosition.value[1] -
						(-event.movementY * this.uPlaneWidth.value[0]) /
							this.canvas?.width!,
				];
				this.frame();
				console.log('moved');
			}
		});

		const resizeObserver = new ResizeObserver(this.onResize.bind(this));

		resizeObserver.observe(canvas, { box: 'content-box' });

		window.addEventListener('fractal-interact', (event) => {
			let action = parseInt((event as CustomEvent).detail) as DefaultAction;
			console.log(action);
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
					this.frame();
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
		this.resizeCanvas();

		this.context.clearColor(0, 0, 0, 0);
		this.context.clear(this.context.COLOR_BUFFER_BIT);

		this.context.useProgram(this.program);
	}

	public frame() {
		requestAnimationFrame((timestamp: number) => {
			let el = document.getElementById('fps')!;

			let delta = (timestamp - this.lastDraw) / 1000;

			if (delta < 1) {
				el.innerText = (1 / delta).toFixed(1);
			}

			this.lastDraw = timestamp;

			this.draw();
		});
	}

	public abstract home(): void;
}
