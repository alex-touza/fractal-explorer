import {
	Fractal,
	type FractalCanvas,
	type FractalDataset,
} from '../main/Fractal.ts';
import { default as vertex } from './mandelbrot.vert?raw';
import { default as fragment } from './mandelbrot.frag?raw';
import { mandelbrot } from '@data/fractals.ts';
import { Uniform1i } from '@opengl/main/Uniforms.ts';

export interface MandelbrotDataset extends FractalDataset {
	maxIterations: string;
}

export class MandelbrotFractal extends Fractal<MandelbrotDataset> {
	private buffer: WebGLBuffer | null = null;

	public constructor() {
		super(
			'mandelbrot',
			mandelbrot,
			[
				['fragment', fragment],
				['vertex', vertex],
			],
			[
				new Uniform1i('uMaxIterations', () => [
					parseInt(
						(document.getElementById('iterationsSlider') as HTMLInputElement)
							.value as string,
					),
				]),
			],
		);
	}

	public override begin(canvas: FractalCanvas<MandelbrotDataset>) {
		super.begin(canvas);

		this.home();

		if (this.context === null) throw 'context null';

		this.newAttribute('aTriPosition'); // Posició dels vèrtexs dels triangles

		this.buffer = this.context.createBuffer();

		this.canvas?.addEventListener('click', (event: MouseEvent) => {
			console.log('mouse screen pos', event.clientX, event.clientY);
			console.log(
				'mouse plane pos',
				this.screenToPlane(event.clientX, event.clientY),
			);
		});
	}

	public override draw() {
		if (this.context === null) throw 'context null';

		super.draw();

		document
			.getElementById('iterationsSlider')!
			.addEventListener('change', () => {
				if (Date.now() - this.lastDraw > 200) {
					this.draw();
				}
			});

		if (this.canvas?.width === 0) throw 'canvas width 0';
		if (!this.canvas?.dataset) throw 'canvas dataset not set';

		this.context.bindBuffer(this.context.ARRAY_BUFFER, this.buffer!);

		this.context.bufferData(
			this.context.ARRAY_BUFFER,
			new Float32Array([-1, 1, -1, -1, 1, 1, 1, -1]),
			this.context.STATIC_DRAW,
		);

		let vertArray = this.context.createVertexArray();

		this.context.bindVertexArray(vertArray);

		const attribLoc = this.attributes.get('aTriPosition')!;

		this.context.enableVertexAttribArray(attribLoc);

		this.context.vertexAttribPointer(
			attribLoc,
			2,
			this.context.FLOAT,
			false,
			0,
			0,
		);

		super.assignUniforms();
		this.context.drawArrays(this.context.TRIANGLE_STRIP, 0, 4);
	}

	public override home() {
		this.canvas!.dataset.zoom = '0.006';
		this.canvas!.dataset.posX = '0';
		this.canvas!.dataset.posY = '0';
	}
}
