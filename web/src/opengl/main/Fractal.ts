import { shaderTypes } from '../shaderTypes.ts';
import type { FractalInfo } from '@data/fractal.ts';
import type { WheelEvent } from 'react';
import { Uniform1f, Uniform2f, type Uniforms } from '@opengl/main/Uniforms.ts';

let displayWidth: number, displayHeight: number;

export interface FractalDataset extends DOMStringMap {
	zoom: string;
	offsetX: string;
	offsetY: string;
}

export interface FractalCanvas<Dataset extends FractalDataset = FractalDataset>
	extends HTMLCanvasElement {
	dataset: Dataset;
}

export abstract class Fractal<Dataset extends FractalDataset = FractalDataset> {
	public id: string;
	public info: FractalInfo;

	public context: WebGL2RenderingContext | null = null;
	public canvas: FractalCanvas<Dataset> | null = null;
	public program: WebGLProgram | null = null;
	public shaders: [keyof typeof shaderTypes, string][];

	protected uniforms: Uniforms[] = [
		new Uniform2f('uResolution', () => [
			this.context!.canvas.width,
			this.context!.canvas.height,
		]),
		new Uniform1f('uZoom', 1.0),
		new Uniform2f('uPosition', 0.0, 0.0),
	];

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
		this.uniforms.push(...uniforms);
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

	/*
    protected newUniform(name: string): WebGLUniformLocation {
        const loc = this.context!.getUniformLocation(this.program!, name);
        if (loc === null) throw 'location is null';

        this.uniforms.set(name, loc);

        return loc;
    }
*/
	protected newAttribute(name: string): GLint {
		const loc = this.context!.getAttribLocation(this.program!, name);
		if (loc === null) throw 'location is null';

		this.attributes.set(name, loc);

		return loc;
	}

	private onScroll(_event: Event) {
		let event: WheelEvent = _event as unknown as WheelEvent;

		console.log(event.clientX, event.clientY);

		if (!this.canvas) return;

		let zoomDelta = event.deltaY > 0 ? 1.2 : 0.8;

		let dataset = this.canvas!.dataset;

		dataset.zoom = String(zoomDelta * parseFloat(dataset.zoom));

		dataset.offsetX = String(
			parseFloat(dataset.offsetX) +
				((event.clientX - this.canvas?.width / 2) / this.canvas!.width) *
					parseFloat(dataset.zoom),
		);

		dataset.offsetY = String(
			parseFloat(dataset.offsetY) +
				((-event.clientY + this.canvas?.height / 2) / this.canvas!.height) *
					parseFloat(dataset.zoom),
		);

		console.log(
			'wheel',
			event.clientX - this.canvas?.width / 2,
			this.canvas?.dataset.zoom,
		);
		requestAnimationFrame(() => this.draw());
	}

	public begin(canvas: FractalCanvas<Dataset>) {
		this.canvas = canvas;
		this.context = this.canvas.getContext('webgl2')!;
		this.program = this.context!.createProgram();

		if (!this.program || !this.context) throw 'program or context null';

		this.canvas.addEventListener('wheel', this.onScroll);

		const resizeObserver = new ResizeObserver((entries) => {
			console.log('resizeObserver triggered');
			for (const entry of entries) {
				let width;
				let height;
				let dpr = window.devicePixelRatio;
				if (entry.devicePixelContentBoxSize) {
					// NOTE: Only this path gives the correct answer
					// The other paths are imperfect fallbacks
					// for browsers that don't provide anyway to do this
					width = entry.devicePixelContentBoxSize[0].inlineSize;
					height = entry.devicePixelContentBoxSize[0].blockSize;
					dpr = 1; // it's already in width and height
				} else if (entry.contentBoxSize) {
					if (entry.contentBoxSize[0]) {
						width = entry.contentBoxSize[0].inlineSize;
						height = entry.contentBoxSize[0].blockSize;
					} else {
						width = entry.contentBoxSize.inlineSize;
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
		});
		resizeObserver.observe(canvas, { box: 'content-box' });

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
}
